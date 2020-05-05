import '../common/human.dart';
import '../common/life_event.dart';
import '../common/life_item.dart';
import '../common/life_step.dart';

class LifeStageModel {
  LifeStageModel(this.human);

  HumanModel human;
  List<LifeItemModel> lifeItems;
  List<LifeEventModel> lifeEventRecord;
  LifeStepModel lifeStepModel;
}
