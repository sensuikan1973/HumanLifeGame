import 'package:collection/collection.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import '../../api/dice.dart';
import '../../api/firestore/life_event_record.dart';
import '../../api/firestore/life_stage.dart';
import '../../api/firestore/play_room.dart';
import '../../api/firestore/store.dart';
import '../../entities/life_event_target.dart';
import '../../entities/life_item.dart';
import '../../entities/life_step_entity.dart';
import '../../i18n/i18n.dart';
import '../../services/life_event_service.dart';
import 'play_room_state.dart';

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
  PlayRoomNotifier(this._i18n, this._dice, this._store, this._playRoom) : super(PlayRoomState());

  final I18n _i18n;
  final Dice _dice;
  final Store _store;
  final Doc<PlayRoomEntity> _playRoom;
  final _lifeEventService = const LifeEventService();

  int get _currentHumanLifeStageIndex =>
      value.lifeStages.indexWhere((lifeStage) => lifeStage.human.documentID == value.currentTurnHuman.id);
  LifeStageEntity get _currentHumanLifeStage => value.lifeStages[_currentHumanLifeStageIndex];

  /// 進む数の残り
  int _remainCount = 0;

  /// 初期化する
  /// LifeRoad や User の取得、LifeStage の初期値追加
  /// TODO: コンストラクタ内でやればいい。そして、UI 側は listen するように改修する。んで、非同期処理の完了について無知でいられる。
  Future<void> init() async {
    value
      ..lifeRoad = await _playRoom.entity.fetchLifeRoad(_store)
      ..humans = await _playRoom.entity.fetchHumans(_store)
      ..currentTurnHuman = value.humans.first; // TODO: 順序付けのあり方検討
    await _startGame(); // TODO: これは host がゲーム開始ボタン押した時にやること
  }

  /// ゲームを開始する
  Future<void> _startGame() async {
    // 参加者全員の位置を Start に
    for (final human in value.humans) {
      final lifeStage = LifeStageEntity(
        human: human.ref,
        currentLifeStepId: value.lifeRoad.entity.start.id,
        items: const UnmodifiableSetView<LifeItemEntity>.empty(),
      );
      await _store.collectionRef<LifeStageEntity>(parent: _playRoom.ref.path).docRef(human.id).set(lifeStage);
      value.lifeStages.add(lifeStage); // FIXME: listen する
    }
  }

  /// Dice を振って進む
  Future<void> rollDice() async {
    if (value.allHumansReachedTheGoal || value.requireSelectDirection) return;
    value
      ..roll = _dice.roll()
      ..announcement =
          _i18n.rollAnnouncement(value.currentTurnHuman.entity.displayName, value.roll); // TODO: 状態に応じた適切なメッセージを流すように

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
      await _executeEvent();
      await _changeToNextTurn();
    }
    notifyListeners();
  }

  /// 分岐路において、進行方向を選択して進む
  Future<void> chooseDirection(Direction direction) async {
    if (value.allHumansReachedTheGoal || !value.requireSelectDirection) return;
    final dest = _moveLifeStepUntilMustStop(_remainCount, firstDirection: direction);
    _updateRequireSelectDirectionAndRemainCount(dest);

    // TODO: 今は requireSelectDirection だけだけど、今後は requireDiceRoll とかも考慮しなきゃいけなくなる
    if (!value.requireSelectDirection) {
      await _executeEvent();
      await _changeToNextTurn();
    }
    notifyListeners();
  }

  Future<void> _executeEvent() async {
    final lifeEvent = value.lifeRoad.entity.getStepEntity(_currentHumanLifeStage).lifeEvent;

    // LifeStage を更新
    value.lifeStages = [...value.lifeStages];
    if (lifeEvent.target == LifeEventTarget.myself) {
      value.lifeStages[_currentHumanLifeStageIndex] = _lifeEventService.executeEvent(
        lifeEvent,
        [value.lifeStages[_currentHumanLifeStageIndex]],
      ).first;
    } else if (lifeEvent.target == LifeEventTarget.all) {
      value.lifeStages = _lifeEventService.executeEvent(lifeEvent, value.lifeStages);
    }

    // LifeEventRecord を更新
    final record = LifeEventRecordEntity(
      human: _currentHumanLifeStage.human,
      lifeEvent: value.lifeRoad.entity.getStepEntity(_currentHumanLifeStage).lifeEvent,
    );
    await _store.collectionRef<LifeEventRecordEntity>(parent: _playRoom.ref.path).add(record);
    value.everyLifeEventRecords = [...value.everyLifeEventRecords, record]; // FIXME: listen する
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
  Future<void> _changeToNextTurn() async {
    final humans = await _playRoom.entity.fetchHumans(_store);
    final currentHumanIndex = humans.indexOf(value.currentTurnHuman);
    await _playRoom.ref.updateData(
      <String, dynamic>{
        PlayRoomEntityField.currentTurnHumanId.name: humans[currentHumanIndex].id,
        TimestampField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
    value.currentTurnHuman = humans[(currentHumanIndex + 1) % humans.length]; // FIXME: listen する

    if (value.allHumansReachedTheGoal) return;
    // 現在手番の Human がゴールしていたら次の Human にターンを変える
    if (value.currentHumanLifeStep.isGoal) await _changeToNextTurn();
  }

  DestinationWithMovedStepCount _moveLifeStepUntilMustStop(int roll, {Direction firstDirection}) {
    // 現在の LifeStep から指定の数だけ進んだ LifeStep を取得する
    final destinationWithMovedStepCount = value.lifeRoad.entity
        .getStepEntity(_currentHumanLifeStage)
        .getNextUntilMustStopStep(roll, firstDirection: firstDirection);
    // 進み先の LifeStep を LifeStage に代入する
    value.lifeStages[_currentHumanLifeStageIndex] = value.lifeStages[_currentHumanLifeStageIndex]
        .copyWith(currentLifeStepId: destinationWithMovedStepCount.destination.id);
    return destinationWithMovedStepCount;
  }
}
