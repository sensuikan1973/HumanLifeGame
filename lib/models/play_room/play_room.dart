import 'package:flutter/foundation.dart';

import '../../i18n/i18n.dart';
import '../../services/life_event_service.dart';
import '../common/human.dart';
import '../common/human_life.dart';
import '../common/life_event.dart';
import '../common/life_road.dart';
import 'announcement.dart';
import 'life_stage.dart';
import 'player_action.dart';

class PlayRoomNotifier extends ChangeNotifier {
  PlayRoomNotifier(
    this._i18n,
    this.humanLife, {
    @required this.orderedHumans,
  }) {
    // 参加者全員の位置を Start に
    for (final human in orderedHumans) {
      final lifeStage = LifeStageModel(human)..lifeStepModel = humanLife.lifeRoad.start;
      lifeStages.add(lifeStage);
    }
    // 一番手の set
    _currentPlayer = orderedHumans.first;
  }

  final I18n _i18n;
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

  /// 参加者のそれぞれの人生の進捗
  List<LifeStageModel> lifeStages = [];

  /// 参加者それぞれの位置情報
  Map<String, Position> get positionsByHumanId => {
        for (final lifeStage in lifeStages) lifeStage.human.id: humanLife.lifeRoad.getPosition(lifeStage.lifeStepModel),
      };

  /// 全参加者それぞれの LifeEvent 履歴
  List<LifeEventModel> everyLifeEventRecords;

  /// 参加者全員がゴールに到着したかどうか
  bool get allHumansReachedTheGoal => lifeStages.every((lifeStage) => lifeStage.lifeStepModel.isGoal);

  void update(PlayerActionNotifier playerActionNotifier) {
    // まだサイコロが振られてない時は何もしない
    if (playerActionNotifier.neverRolled) return;

    // Announcement の更新
    announcement.message = _i18n.rollAnnouncement(_currentPlayer.name, playerActionNotifier.roll);
    // 人生を進める
    _moveLifeStep(playerActionNotifier.roll);

    // LifeEvent 処理
    lifeStages[_currentPlayerLifeStageIndex] = _lifeEventService.executeEvent(
      _currentPlayerLifeStage.lifeStepModel.lifeEvent,
      _currentPlayerLifeStage,
    );

    // FIXME: 即ターン交代してるけど、あくまで仮
    _changeToNextTurn();

    notifyListeners();
  }

  // 次のターンに変える
  void _changeToNextTurn() {
    final currentPlayerIndex = orderedHumans.indexOf(_currentPlayer);
    _currentPlayer = orderedHumans[(currentPlayerIndex + 1) % orderedHumans.length];
  }

  void _moveLifeStep(int roll) {
    // 現在の LifeStep から指定の数だけ進んだ LifeStep を取得する
    final destinationWithMovedStepCount = _currentPlayerLifeStage.lifeStepModel.getNextUntilMustStopStep(roll);
    // 進み先の LifeStep を LifeStage に代入する
    lifeStages[_currentPlayerLifeStageIndex].lifeStepModel = destinationWithMovedStepCount.destination;
  }
}
