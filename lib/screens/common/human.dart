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
    Icon(Icons.directions_run, color: Colors.red, size: 24),
    Icon(Icons.directions_bike, color: Colors.blue, size: 24),
    Icon(Icons.directions_car, color: Colors.green, size: 24),
    Icon(Icons.atm, color: Colors.yellow, size: 24),
  ];

  static const orderedIconShadow = [
    Icon(Icons.directions_run, color: Colors.black12, size: 24),
    Icon(Icons.directions_bike, color: Colors.black12, size: 24),
    Icon(Icons.directions_car, color: Colors.black12, size: 24),
    Icon(Icons.atm, color: Colors.black12, size: 24),
  ];
  @override
  Widget build(BuildContext context) => Stack(children: <Widget>[
        Positioned(top: 2, left: 2, child: orderedIconShadow[_humanModel.order]),
        orderedIcon[_humanModel.order],
      ]);
}
