import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import '../../api/dice.dart';
import '../../api/firestore/play_room.dart';
import '../../i18n/i18n.dart';
import '../../services/life_event_service.dart';
import '../common/human.dart';
import '../common/human_life.dart';
import '../common/life_step.dart';
import 'life_event_record.dart';
import 'life_stage.dart';
import 'play_room_state.dart';

@immutable
class PlayRoomNotifierArguments {
  const PlayRoomNotifierArguments(this.playRoom);
  final Document<PlayRoomEntity> playRoom;
}

/// NOTE: 以下の点を把握した上で状態管理を実装すること.
///
/// * 独自に定義した Class を Value としているため、notifyListeners() の明示的な呼び出しが必要である点.
///     * See: <https://youtu.be/s-ZG-jS5QHQ?t=57>
/// * State は現状 mutable である点.
///     * immutable に扱おうと思うと、"value = State(a, b, c, d...)" という代入による更新が必要であり面倒.
///     * copy_with_extension や freezed で copyWith を生やせば対応可能なので、必要に迫られたら導入する.
/// * provider の文脈での参照にやや難がある点.
///     * PlayRoomNotifier に関して Widget が参照したいのは、value(PlayRoomState) と PlayRoomNotifier インスタンス の 2 つである.<br>
///       ValueNotifierProvider だと value(PlayRoomState) を provide することになるため、PlayRoomNotifier インスタンスを provide できない.<br>
///       そのため、現状は ChangeNotifierProvider で PlayRoomNotifier インスタンスを provide し、`.value` を必要に応じて参照することにしている.<br>
///     * flutter_state_notifier を導入することで対応可能(notifyListeners の話も含め)なので、必要に迫られたら導入する.
class PlayRoomNotifier extends ValueNotifier<PlayRoomState> {
  PlayRoomNotifier(
    this._i18n,
    this._dice,
    HumanLifeModel humanLife,
    List<HumanModel> humans,
  ) : super(PlayRoomState(
          humanLife,
          humans..sort((a, b) => a.order.compareTo(b.order)),
        )) {
    // 参加者全員の位置を Start に
    for (final human in value.orderedHumans) {
      final lifeStage = LifeStageModel(
        human: human,
        lifeStepModel: value.humanLife.lifeRoad.start,
        lifeItems: [],
      );
      value.lifeStages.add(lifeStage);
    }
    // 一番手をセット
    value.currentTurnHuman = value.orderedHumans.first;
  }

  final I18n _i18n;
  final Dice _dice;
  final _lifeEventService = const LifeEventService();

  int get _currentHumanLifeStageIndex =>
      value.lifeStages.indexWhere((lifeStage) => lifeStage.human == value.currentTurnHuman);
  LifeStageModel get _currentHumanLifeStage => value.lifeStages[_currentHumanLifeStageIndex];

  // 進む数の残り
  int _remainCount = 0;

  void rollDice() {
    if (value.allHumansReachedTheGoal || value.requireSelectDirection) return;
    value
      ..roll = _dice.roll()
      ..announcement = _i18n.rollAnnouncement(value.currentTurnHuman.name, value.roll); // FIXME: 状態に応じた適切なメッセージを流すように

    // サイコロ振る出発地点が分岐なら、サイコロ振るのを求めて notify でお終い
    if (value.currentHumanLifeStep.requireToSelectDirectionManually) {
      _remainCount = value.roll;
      value.requireSelectDirection = true;
      return notifyListeners();
    }

    final dest = _moveLifeStepUntilMustStop(value.roll);
    _updateRequireSelectDirectionAndRemainCount(dest);

    // TODO: 今は requireSelectDirection だけだけど、今後は requireDiceRoll とかも考慮しなきゃいけなくなる
    if (!value.requireSelectDirection) {
      _executeEventToCurrentHuman();
      _changeToNextTurn();
    }
    notifyListeners();
  }

  void chooseDirection(Direction direction) {
    if (value.allHumansReachedTheGoal || !value.requireSelectDirection) return;
    final dest = _moveLifeStepUntilMustStop(_remainCount, firstDirection: direction);
    _updateRequireSelectDirectionAndRemainCount(dest);

    // TODO: 今は requireSelectDirection だけだけど、今後は requireDiceRoll とかも考慮しなきゃいけなくなる
    if (!value.requireSelectDirection) {
      _executeEventToCurrentHuman();
      _changeToNextTurn();
    }
    notifyListeners();
  }

  void _executeEventToCurrentHuman() {
    // LifeEvent 処理
    value.lifeStages = [...value.lifeStages];
    value.lifeStages[_currentHumanLifeStageIndex] = _lifeEventService.executeEvent(
      _currentHumanLifeStage.lifeStepModel.lifeEvent,
      _currentHumanLifeStage,
    );
    // LifeEvent の履歴を更新
    value.everyLifeEventRecords = [
      ...value.everyLifeEventRecords,
      LifeEventRecordModel(_i18n, _currentHumanLifeStage.human, _currentHumanLifeStage.lifeStepModel.lifeEvent)
    ];
  }

  void _updateRequireSelectDirectionAndRemainCount(DestinationWithMovedStepCount dest) {
    // NOTE: 選択を要するところが到着の場合、そこが最終地点なら選択は次のターンに後回しとするため、「dest.remainCount > 0」としてる
    value.requireSelectDirection = dest.remainCount > 0 && dest.destination.requireToSelectDirectionManually;
    if (value.requireSelectDirection) {
      _remainCount = dest.remainCount;
    } else {
      _remainCount = 0; // リセット
    }
  }

  // 次のターンに変える
  void _changeToNextTurn() {
    final currentHumanIndex = value.orderedHumans.indexOf(value.currentTurnHuman);
    value.currentTurnHuman = value.orderedHumans[(currentHumanIndex + 1) % value.orderedHumans.length];

    if (value.allHumansReachedTheGoal) return;
    // 現在手番の Human がゴールしていたら次の Human にターンを変える
    if (value.currentHumanLifeStep.isGoal) _changeToNextTurn();
  }

  DestinationWithMovedStepCount _moveLifeStepUntilMustStop(int roll, {Direction firstDirection}) {
    // 現在の LifeStep から指定の数だけ進んだ LifeStep を取得する
    final destinationWithMovedStepCount =
        _currentHumanLifeStage.lifeStepModel.getNextUntilMustStopStep(roll, firstDirection: firstDirection);
    // 進み先の LifeStep を LifeStage に代入する
    value.lifeStages[_currentHumanLifeStageIndex] = value.lifeStages[_currentHumanLifeStageIndex]
        .copyWith(lifeStepModel: destinationWithMovedStepCount.destination);
    return destinationWithMovedStepCount;
  }
}
