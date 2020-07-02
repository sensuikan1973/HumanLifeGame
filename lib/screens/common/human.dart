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
    Icon(Icons.directions_run, color: Colors.red, size: 25),
    Icon(Icons.directions_bike, color: Colors.blue, size: 25),
    Icon(Icons.directions_car, color: Colors.green, size: 25),
    Icon(Icons.atm, color: Colors.yellow, size: 25),
  ];

  static const _orderedIconShadow = [
    Icon(Icons.directions_run, color: Colors.black12, size: 25),
    Icon(Icons.directions_bike, color: Colors.black12, size: 25),
    Icon(Icons.directions_car, color: Colors.black12, size: 25),
    Icon(Icons.atm, color: Colors.black12, size: 25),
  ];
  @override
  Widget build(BuildContext context) => Stack(children: <Widget>[
        Positioned(top: 2, left: 2, child: _orderedIconShadow.first),
        orderedIcon.first,
      ]);
}
