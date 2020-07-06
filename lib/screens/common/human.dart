import 'package:flutter/material.dart';

import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';

class Human extends StatelessWidget {
  const Human(this._user, {Key key}) : super(key: key);

  final Doc<UserEntity> _user;

  String get humanId => _user.entity.uid;

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
