import 'package:flutter/material.dart';

import '../../models/common/life_event_params/life_event_params.dart';
import '../../models/common/life_road.dart';
import '../../models/common/life_step.dart';
import 'human.dart';
import 'life_step.dart';

class LifeRoad extends StatelessWidget {
  LifeRoad(
    this._model,
    this._width,
    this._height, {
    List<Human> humans,
    Map<String, Position> positionsByHumanId,
    Key key,
  })  : _humans = humans ?? [],
        _positionsByHumanId = positionsByHumanId ?? {},
        super(key: key);

  final LifeRoadModel _model;

  final List<Human> _humans;
  final Map<String, Position> _positionsByHumanId;

  final double _width;
  final double _height;

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
  Widget build(BuildContext context) => Table(
        children: List.generate(
          _model.height,
          (y) => TableRow(
            children: List.generate(
              _model.width,
              (x) => TableCell(
                child: SizedBox(
                  width: _width / _model.width,
                  height: _height / _model.height,
                  child: _lifeStep(_model.lifeStepsOnBoard[y][x], _putTargetHumans(x, y)),
                ),
              ),
            ),
          ),
        ),
      );

  LifeStep _lifeStep(LifeStepModel model, List<Human> humans) {
    if (model.lifeEvent.type == LifeEventType.nothing) {
      return null;
    } else {
      return LifeStep(
        model,
        humans: humans,
      );
    }
  }
}
