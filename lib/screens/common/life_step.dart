import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:flutter/material.dart';

class LifeStep extends StatelessWidget {
  const LifeStep(this.model);
  final LifeEventModel model;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 49,
        height: 39,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: model.type == LifeEventType.nothing ? Colors.white : Colors.grey,
            ),
          ),
        ),
      );
}
