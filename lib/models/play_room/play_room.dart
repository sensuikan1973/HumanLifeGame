import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/announcement.dart';
import 'package:HumanLifeGame/models/play_room/life_stage.dart';
import 'package:HumanLifeGame/models/play_room/player_action.dart';
import 'package:flutter/foundation.dart';

class PlayRoomModel extends ChangeNotifier {
  PlayRoomModel(this._i18n);

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
      // FIXME: 仮で即ターン交代してる
      final currentPlayerIndex = humans.indexOf(_currentPlayer);
_currentPlayer = humans[ (currentPlayerIndex + 1) % humans.length ]
    } else {
      _currentPlayer = humans.first;
    }

    notifyListeners();
  }

  final _announcement = AnnouncementModel();
  AnnouncementModel get announcement => _announcement;

  String roomTitle;

  // 参加する人
  // 順番付け済み
  List<HumanModel> humans = [
    HumanModel('human_1_id', 'human_1_name'),
    HumanModel('human_2_id', 'human_2_name'),
  ];

  // FIXME: 仮でダミーデータの一人を常に返す
  // 手番の人
  HumanModel _currentPlayer;

  // 参加者のそれぞれの人生の進捗
  List<LifeStageModel> lifeStages;

  // 全参加者の LifeEvent 履歴
  List<LifeEventModel> everyLifeEventRecords;
}
