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
    author: UserModel('dummyUseUd', 'dummyUser', DateTime.now(), DateTime.now()),
    lifeRoad: LifeRoadModel.dummy(),
  );

  PlayerActionModel _playerAction;
  PlayerActionModel get playerAction => _playerAction;
  set playerAction(PlayerActionModel playerAction) {
    _playerAction = playerAction;
    announcement.message = _i18n.rollAnnouncement(playerAction.roll);
    notifyListeners();
  }

  final _announcement = AnnouncementModel();
  AnnouncementModel get announcement => _announcement;

  String roomTitle;

  // 参加する人
  List<HumanModel> humans;

  // 参加者のそれぞれの人生の進捗
  List<LifeStageModel> lifeStages;

  // 手番の人
  HumanModel currentPlayer;

  // 全参加者の LifeEvent 履歴
  List<LifeEventModel> everyLifeEventRecords;
}
