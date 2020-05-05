import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';

class LifeRoad extends StatelessWidget {
  const LifeRoad(this.lifeRoadModel, {Key key}) : super(key: key);

  final LifeRoadModel lifeRoadModel;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 1050,
        height: 700,
        child: LayoutBuilder(
          builder: (context, constraints) => Table(
            children: List.generate(
              LifeRoadModel.width,
              (yAxisIndex) => TableRow(
                children: List.generate(
                  LifeRoadModel.height,
                  (xAxisIndex) => TableCell(
                    child: LifeStep(
                      lifeRoadModel.lifeStepsOnBoard[yAxisIndex][xAxisIndex],
                      constraints.maxWidth,
                      constraints.maxHeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
