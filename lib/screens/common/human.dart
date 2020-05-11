import 'package:flutter/material.dart';

import '../../models/common/human.dart';

class Human extends StatelessWidget {
  const Human(
    this._humanModel,
    this._color, {
    Key key,
  }) : super(key: key);

  final HumanModel _humanModel;
  final Color _color;

  String get humanId => _humanModel.id;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 20,
        height: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
