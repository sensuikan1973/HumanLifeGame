import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/screens/play_room/human.dart';
import 'package:flutter/material.dart';

class LifeStep extends StatelessWidget {
  const LifeStep(this.model);
  final LifeEventModel model;
  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          SizedBox(
            width: 1000 / 7,
            height: 690 / 7,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: model.type == LifeEventType.nothing ? Colors.amber[50] : Colors.cyan[50],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: Human(),
          ),
        ],
      );
}
