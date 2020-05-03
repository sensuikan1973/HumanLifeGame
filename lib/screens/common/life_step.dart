import 'package:HumanLifeGame/models/life_step.dart';
import 'package:flutter/material.dart';

class LifeStep extends StatelessWidget {
  const LifeStep(this.model);
  final LifeStepModel model;
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 49,
          height: 39,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: model == null ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      );
}
