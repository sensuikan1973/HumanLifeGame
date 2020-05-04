import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';

class LifeRoad extends StatelessWidget {
  const LifeRoad(this.lifeRoadModel);
  final LifeRoadModel lifeRoadModel;
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 1050,
          height: 700,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Table(
              children: List.generate(
                7,
                (yAxisIndex) => TableRow(
                  children: List.generate(
                    7,
                    (xAxisIndex) => TableCell(
                      child: LifeStep(
                        lifeRoadModel.lifeStepsOnBoard[yAxisIndex][xAxisIndex].lifeEvent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
