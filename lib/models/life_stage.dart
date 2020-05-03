import 'package:HumanLifeGame/models/human.dart';
import 'package:HumanLifeGame/models/life_event.dart';
import 'package:HumanLifeGame/models/life_item.dart';
import 'package:HumanLifeGame/models/life_step.dart';

class LifeStageModel {
  LifeStageModel(this.human);

  HumanModel human;
  List<LifeItemModel> lifeItems;
  List<LifeEventModel> lifeEventRecord;
  LifeStepModel lifeStepModel;
}
