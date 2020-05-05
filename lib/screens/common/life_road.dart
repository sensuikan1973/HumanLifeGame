import 'package:flutter/material.dart';

import '../../models/common/life_road.dart';
import '../play_room/human.dart';
import 'life_step.dart';

class LifeRoad extends StatelessWidget {
  LifeRoad(
    this._lifeRoadModel, {
    List<Human> humans,
    Map<String, Position> positionsByHumanId,
    Key key,
  })  : _humans = humans ?? [],
        _positionsByHumanId = positionsByHumanId ?? {},
        super(key: key);

  final LifeRoadModel _lifeRoadModel;

  final List<Human> _humans;
  final Map<String, Position> _positionsByHumanId;

  // LifeStep の上に載せる対象の Human を取得する
  List<Human> _putTargetHumans(int x, int y) {
    final list = <Human>[];
    for (final human in _humans) {
      final position = _positionsByHumanId[human.humanId];
      if (x == position.x && y == position.y) list.add(human);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 1050,
        height: 700,
        child: LayoutBuilder(
          builder: (context, constraints) => Table(
            children: List.generate(
              LifeRoadModel.width,
              (y) => TableRow(
                children: List.generate(
                  LifeRoadModel.height,
                  (x) => TableCell(
                    child: LifeStep(
                      _lifeRoadModel.lifeStepsOnBoard[y][x],
                      constraints.maxWidth,
                      constraints.maxHeight,
                      humans: _putTargetHumans(x, y),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
