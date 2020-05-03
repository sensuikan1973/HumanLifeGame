import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_item.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';

class LifeStageModel {
  LifeStageModel(this.human);

  HumanModel human;
  List<LifeItemModel> lifeItems;
  List<LifeEventModel> lifeEventRecord;
  LifeStepModel lifeStepModel;
}
