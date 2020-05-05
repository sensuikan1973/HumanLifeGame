import 'package:flutter/material.dart';

import '../../models/common/human.dart';

class Human extends StatelessWidget {
  const Human(this._humanModel, {Key key}) : super(key: key);

  final HumanModel _humanModel;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 20,
        height: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(_humanModel.name),
        ),
      );
}
