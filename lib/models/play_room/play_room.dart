import 'package:flutter/foundation.dart';

import '../../api/dice.dart';
import '../../i18n/i18n.dart';
import '../../services/life_event_service.dart';
import '../common/human.dart';
import '../common/human_life.dart';
import '../common/life_road.dart';
import '../common/life_step.dart';
import 'announcement.dart';
import 'life_event_record.dart';
import 'life_stage.dart';
import 'player_action.dart';

class PlayRoomNotifier extends ChangeNotifier {
  PlayRoomNotifier(
    this._i18n,
    this._dice,
    this.humanLife,
    List<HumanModel> humans,
  ) : orderedHumans = humans..sort((a, b) => a.order.compareTo(b.order)) {
    // 参加者全員の位置を Start に
    for (final human in humans) {
      final lifeStage = LifeStageModel(human)..lifeStepModel = humanLife.lifeRoad.start;
      lifeStages.add(lifeStage);
    }
    // 一番手の set
    _currentPlayer = orderedHumans.first;
  }

  final I18n _i18n;
  final Dice _dice;
  final _lifeEventService = const LifeEventService();

  /// 歩む対象となる人生
  final HumanLifeModel humanLife;

  /// 参加する人。ターン順。
  final List<HumanModel> orderedHumans;

  /// お知らせ
  AnnouncementModel get announcement => _announcement;
  final _announcement = AnnouncementModel();

  /// 部屋のタイトル名
  String roomTitle;

  /// 現在手番の人
  HumanModel get currentPlayer => _currentPlayer;
  HumanModel _currentPlayer;
  int get _currentPlayerLifeStageIndex => lifeStages.indexWhere((lifeStage) => lifeStage.human == _currentPlayer);
  LifeStageModel get _currentPlayerLifeStage => lifeStages[_currentPlayerLifeStageIndex];
  LifeStepModel get currentPlayerLifeStep => _currentPlayerLifeStage.lifeStepModel;

  /// 参加者のそれぞれの人生の進捗
  List<LifeStageModel> lifeStages = [];

  /// 参加者それぞれの位置情報
  Map<String, Position> get positionsByHumanId => {
        for (final lifeStage in lifeStages) lifeStage.human.id: humanLife.lifeRoad.getPosition(lifeStage.lifeStepModel),
      };

  /// 全参加者それぞれの LifeEvent 履歴
  List<LifeEventRecordModel> everyLifeEventRecords = [];

  /// 参加者全員がゴールに到着したかどうか
  bool get allHumansReachedTheGoal => lifeStages.every((lifeStage) => lifeStage.lifeStepModel.isGoal);

  /// 現在手番の人に方向の選択を求めるかどうか
  bool _requireSelectDirection = false;
  bool get requireSelectDirection => _requireSelectDirection;

  /// 進む数の残り
  int _remainCount = 0;

  void update(PlayerActionNotifier playerActionNotifier) {
    assert(playerActionNotifier != null);
    if (playerActionNotifier.neverRolled || allHumansReachedTheGoal) return;

    // FIXME: 状態に応じた適切なメッセージを流すように
    announcement.message = _i18n.rollAnnouncement(_currentPlayer.name, playerActionNotifier.roll);

    // サイコロ振る出発地点が分岐なら
    if (!_requireSelectDirection && currentPlayerLifeStep.requireToSelectDirectionManually) {
      _remainCount = playerActionNotifier.roll;
      _requireSelectDirection = true;
      notifyListeners();
      return;
    }

    final dest = _requireSelectDirection
        ? _moveLifeStepUntilMustStop(_remainCount, firstDirection: playerActionNotifier.direction)
        : _moveLifeStepUntilMustStop(playerActionNotifier.roll);
    // NOTE: 選択を要するところに止まっても、そこが最終地点なら選択は次のターンに後回しとする
    _requireSelectDirection = dest.remainCount > 0 && dest.destination.requireToSelectDirectionManually;
    if (_requireSelectDirection) {
      _remainCount = dest.remainCount;
      notifyListeners();
      return;
    }
    _remainCount = 0;

    // LifeEvent 処理
    lifeStages = [...lifeStages];
    lifeStages[_currentPlayerLifeStageIndex] = _lifeEventService.executeEvent(
      _currentPlayerLifeStage.lifeStepModel.lifeEvent,
      _currentPlayerLifeStage,
    );

    // LifeEventの履歴を更新
    everyLifeEventRecords = [
      ...everyLifeEventRecords,
      LifeEventRecordModel(_i18n, _currentPlayerLifeStage.human, _currentPlayerLifeStage.lifeStepModel.lifeEvent)
    ];

    _changeToNextTurn(); // FIXME: 即ターン交代してるけど、あくまで仮
    notifyListeners();
  }

  // 次のターンに変える
  void _changeToNextTurn() {
    final currentPlayerIndex = orderedHumans.indexOf(_currentPlayer);
    _currentPlayer = orderedHumans[(currentPlayerIndex + 1) % orderedHumans.length];
  }

  DestinationWithMovedStepCount _moveLifeStepUntilMustStop(int roll, {Direction firstDirection}) {
    // 現在の LifeStep から指定の数だけ進んだ LifeStep を取得する
    final destinationWithMovedStepCount =
        _currentPlayerLifeStage.lifeStepModel.getNextUntilMustStopStep(roll, firstDirection: firstDirection);
    // 進み先の LifeStep を LifeStage に代入する
    lifeStages[_currentPlayerLifeStageIndex].lifeStepModel = destinationWithMovedStepCount.destination;
    return destinationWithMovedStepCount;
  }
}
