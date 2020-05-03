import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';

class HumanLifeModel {
  HumanLifeModel({this.title, this.author, this.lifeRoad});
  String title;
  UserModel author;
  LifeRoadModel lifeRoad;
}
