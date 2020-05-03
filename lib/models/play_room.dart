import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/announcement.dart';
import 'package:HumanLifeGame/models/human.dart';
import 'package:HumanLifeGame/models/human_life.dart';
import 'package:HumanLifeGame/models/life_event.dart';
import 'package:HumanLifeGame/models/player_action.dart';
import 'package:HumanLifeGame/screens/play_room/human_life_stages.dart';
import 'package:flutter/foundation.dart';

class PlayRoomModel extends ChangeNotifier {
  PlayRoomModel(this._i18n);

  final I18n _i18n;

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

  // 歩む対象となる人生
  HumanLifeModel humanLife;

  // 参加者のそれぞれの人生の進捗
  List<HumanLifeStages> humanLifeStages;

  // 手番の人
  HumanModel currentPlayer;

  // 全参加者の LifeEvent 履歴
  List<LifeEventModel> everyLifeEventRecords;
}
