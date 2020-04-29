import 'package:HumanLifeGame/models/human.dart';
import 'package:HumanLifeGame/models/life_event.dart';
import 'package:HumanLifeGame/models/life_item.dart';

class HumanLifeStageModel {
  HumanLifeStageModel(this.human);

  Human human;
  List<LifeItem> lifeItems;
  List<LifeEvent> lifeEventRecord;
}
