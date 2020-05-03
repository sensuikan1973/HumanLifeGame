import 'package:HumanLifeGame/models/life_road.dart';
import 'package:HumanLifeGame/models/life_step.dart';
import 'package:HumanLifeGame/models/user.dart';

class HumanLifeModel {
  HumanLifeModel(this.title, this.author, this.lifeRoad);
  HumanLifeModel.dummy() {
    title = 'dummyTytle';
    lifeRoad = setDummyLifeRoad;
  }

  String title;
  UserModel author;
  LifeRoadModel lifeRoad;

  LifeRoadModel get setDummyLifeRoad {
    LifeRoadModel dummy;
    List<List<LifeStepModel>> lifeStepsOnBoard;
    LifeStepModel lifeStep;
    lifeStepsOnBoard = List.generate(10, (index) => List.generate(10, (index) => null));
    lifeStepsOnBoard[5][5] = lifeStep;
    dummy.lifeStepsOnBoard = lifeStepsOnBoard;
    return dummy;
  }
}
