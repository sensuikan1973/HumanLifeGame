import 'package:HumanLifeGame/models/human.dart';
import 'package:HumanLifeGame/models/life_event.dart';
import 'package:HumanLifeGame/models/life_item.dart';

class HumanLifeStageModel {
  HumanLifeStageModel(this.human);

  HumanModel human;
  List<LifeItemModel> lifeItems;
  List<LifeEventModel> lifeEventRecord;

  // HumanLife 上の位置
  int placeX;
  int placeY;
}
