import 'package:HumanLifeGame/models/announcement.dart';
import 'package:HumanLifeGame/models/human.dart';
import 'package:HumanLifeGame/models/life_event.dart';
import 'package:HumanLifeGame/screens/play_room/human_life_stages.dart';
import 'package:flutter/foundation.dart';

class PlayRoom extends ChangeNotifier {
  List<Human> humans;
  List<HumanLifeStages> humanLifeStages;
  Human currentPlayer;
  List<LifeEvent> everyLifeEventRecords; // all human LifeEventRecord
  Announcement announcement;
}
