import 'package:flutter/material.dart';

import '../../models/common/human.dart';

class Human extends StatelessWidget {
  const Human(
    this._humanModel, {
    Key key,
  }) : super(key: key);

  final HumanModel _humanModel;

  String get humanId => _humanModel.id;

  @visibleForTesting
  static const orderedIcon = [
    Icon(Icons.directions_run, color: Colors.red, size: 20),
    Icon(Icons.directions_bike, color: Colors.blue, size: 20),
    Icon(Icons.directions_car, color: Colors.green, size: 20),
    Icon(Icons.atm, color: Colors.yellow, size: 20),
  ];

  @override
  Widget build(BuildContext context) => orderedIcon[_humanModel.order];
}
