import 'package:flutter/foundation.dart';

import '../../i18n/i18n.dart';
import '../common/human.dart';
import '../common/human_life.dart';
import '../common/life_event.dart';
import '../common/life_road.dart';
import '../common/user.dart';
import 'announcement.dart';
import 'life_stage.dart';
import 'player_action.dart';

class PlayRoomModel extends ChangeNotifier {
  PlayRoomModel(this._i18n) {
    // FIXME: 全部ダミーデータ
    for (final human in humans) {
      final lifeStage = LifeStageModel(human)..lifeStepModel = humanLife.lifeRoad.start;
      lifeStages.add(lifeStage);
    }
  }

  final I18n _i18n;

  // FIXME: 仮でダミーデータを最初から入れてるだけ
  // 歩む対象となる人生
  final HumanLifeModel humanLife = HumanLifeModel(
    title: 'dummy HumanLife',
    author: UserModel('dummyUserId', 'dummyUser', DateTime.now(), DateTime.now()),
    lifeRoad: LifeRoadModel.dummy(),
  );

  PlayerActionModel _playerAction;
  PlayerActionModel get playerAction => _playerAction;
  set playerAction(PlayerActionModel playerAction) {
    _playerAction = playerAction;

    if (_currentPlayer != null) {
      // Announcement の更新
      announcement.message = _i18n.rollAnnouncement(_currentPlayer.name, playerAction.roll);
      // 人生を進める
      _moveLifeStep();
      // FIXME: 即ターン交代してるけど、あくまで仮
      _changeToNextTurn();
    } else {
      _currentPlayer = humans.first;
    }

    notifyListeners();
  }

  final _announcement = AnnouncementModel();
  AnnouncementModel get announcement => _announcement;

  String roomTitle;

  // 参加する人。ターン順。
  // FIXME: 仮のダミーデータに過ぎない
  List<HumanModel> humans = [
    HumanModel('human_1_id', 'human_1_name'),
    HumanModel('human_2_id', 'human_2_name'),
  ];

  // 手番の人
  HumanModel _currentPlayer;

  // 参加者のそれぞれの人生の進捗
  List<LifeStageModel> lifeStages = [];

  // それぞれの位置情報
  Map<String, Position> get positionsByHumanId => {
        for (final lifeStage in lifeStages) lifeStage.human.id: humanLife.lifeRoad.getPosition(lifeStage.lifeStepModel),
      };

  // 全参加者の LifeEvent 履歴
  List<LifeEventModel> everyLifeEventRecords;

  // 次のターンに変える
  void _changeToNextTurn() {
    final currentPlayerIndex = humans.indexOf(_currentPlayer);
    _currentPlayer = humans[(currentPlayerIndex + 1) % humans.length];
  }

  void _moveLifeStep() {
    // 現在の手番の human の LifeStage を取得する
    final targetLifeStageIndex = lifeStages.indexWhere((lifeStage) => lifeStage.human == _currentPlayer);
    final lifeStage = lifeStages[targetLifeStageIndex];
    // 現在の LifeStep から出目の数だけ進んだ LifeStep を取得する
    final destination = lifeStage.lifeStepModel.getNext(playerAction.roll);
    // 進み先の LifeStep を LifeStage に代入する
    lifeStages[targetLifeStageIndex].lifeStepModel = destination;
  }
}
