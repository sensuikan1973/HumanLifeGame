import 'package:flutter/material.dart';

import '../../models/common/human.dart';

class Human extends StatelessWidget {
  const Human(
    this._humanModel, {
    Key key,
  }) : super(key: key);

  final HumanModel _humanModel;

  String get humanId => _humanModel.id;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 20,
        height: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _humanModel.icon,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
