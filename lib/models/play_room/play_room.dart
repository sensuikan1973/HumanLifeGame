import 'package:flutter/foundation.dart';

import '../../i18n/i18n.dart';
import '../common/human.dart';
import '../common/human_life.dart';
import '../common/life_event.dart';
import '../common/life_event_executor.dart';
import '../common/life_road.dart';
import '../common/user.dart';
import 'announcement.dart';
import 'life_stage.dart';
import 'player_action.dart';

class PlayRoomModel extends ChangeNotifier {
  PlayRoomModel(
    this._i18n, {
    HumanLifeModel humanLife,
    List<HumanModel> orderedHumans,
  })  : _orderedHumans = orderedHumans,
        // FIXME: 指定がない時にダミーデータを入れてるが、将来的には消す
        _humanLife = humanLife ??
            HumanLifeModel(
              title: 'dummy HumanLife',
              author: UserModel('dummyUserId', 'dummyUser', DateTime.now(), DateTime.now()),
              lifeRoad: LifeRoadModel.dummy(),
            ) {
    // 参加者全員の位置を Start に
    for (final human in _orderedHumans) {
      final lifeStage = LifeStageModel(human)..lifeStepModel = _humanLife.lifeRoad.start;
      lifeStages.add(lifeStage);
    }
    // 一番手の set
    _currentPlayer = _orderedHumans.first;
  }

  final I18n _i18n;
  final _lifeEventExecutor = LifeEventExecutor();

  // 歩む対象となる人生
  final HumanLifeModel _humanLife;
  HumanLifeModel get humanLife => _humanLife;

  PlayerActionModel _playerAction;
  PlayerActionModel get playerAction => _playerAction;
  set playerAction(PlayerActionModel playerAction) {
    _playerAction = playerAction;

    // まだサイコロが振られてない時は何もしない
    if (playerAction.neverRolled) return;

    // Announcement の更新
    announcement.message = _i18n.rollAnnouncement(_currentPlayer.name, playerAction.roll);
    // 人生を進める
    _moveLifeStep();

    // LifeEvent 処理
    lifeStages[_currentPlayerLifeStageIndex] = _lifeEventExecutor.executeEvent(
      _currentPlayerLifeStage.lifeStepModel.lifeEvent,
      _currentPlayerLifeStage,
    );

    // 全員がゴールに到着しているかどうかを確認
    _allHumansArrivedAtGoal = lifeStages.every((lifeStage) => lifeStage.lifeStepModel.isGoal);
    // FIXME: 即ターン交代してるけど、あくまで仮
    _changeToNextTurn();

    notifyListeners();
  }

  final _announcement = AnnouncementModel();
  AnnouncementModel get announcement => _announcement;

  String roomTitle;

  // 参加する人。ターン順。
  final List<HumanModel> _orderedHumans;
  List<HumanModel> get orderedHumans => _orderedHumans;

  // 手番の人
  HumanModel _currentPlayer;
  HumanModel get currentPlayer => _currentPlayer;

  // 参加者のそれぞれの人生の進捗
  List<LifeStageModel> lifeStages = [];

  int get _currentPlayerLifeStageIndex => lifeStages.indexWhere((lifeStage) => lifeStage.human == _currentPlayer);
  LifeStageModel get _currentPlayerLifeStage => lifeStages[_currentPlayerLifeStageIndex];

  // それぞれの位置情報
  Map<String, Position> get positionsByHumanId => {
        for (final lifeStage in lifeStages)
          lifeStage.human.id: _humanLife.lifeRoad.getPosition(lifeStage.lifeStepModel),
      };

  // 全参加者の LifeEvent 履歴
  List<LifeEventModel> everyLifeEventRecords;

  bool _allHumansArrivedAtGoal = false;
  bool get allHumansArrivedAtGoal => _allHumansArrivedAtGoal;

  // 次のターンに変える
  void _changeToNextTurn() {
    final currentPlayerIndex = _orderedHumans.indexOf(_currentPlayer);
    _currentPlayer = _orderedHumans[(currentPlayerIndex + 1) % _orderedHumans.length];
  }

  void _moveLifeStep() {
    // 現在の LifeStep から出目の数だけ進んだ LifeStep を取得する
    final destination = _currentPlayerLifeStage.lifeStepModel.getNext(playerAction.roll);
    // 進み先の LifeStep を LifeStage に代入する
    lifeStages[_currentPlayerLifeStageIndex].lifeStepModel = destination;
  }
}
