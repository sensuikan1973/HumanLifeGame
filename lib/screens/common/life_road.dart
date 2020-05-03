import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';

class LifeRoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 490,
          height: 390,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Table(
              children: List.generate(
                10,
                (yAxisIndex) => TableRow(
                  children: List.generate(
                    10,
                    (xAxisIndex) => TableCell(
                      child: LifeStep(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
