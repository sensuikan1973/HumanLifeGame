import 'package:firebase_auth/firebase_auth.dart';

import 'life_road.dart';

// FIXME: そもそもこのクラスいらない
class HumanLifeModel {
  HumanLifeModel({this.title, this.author, this.lifeRoad});
  String title;
  FirebaseUser author;
  LifeRoadModel lifeRoad;
}
