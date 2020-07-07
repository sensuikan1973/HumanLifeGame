import 'package:flutter/material.dart';

import '../../api/firestore/life_road.dart';
import '../../entities/life_step_entity.dart';
import '../../models/common/life_event_params/life_event_params.dart';
import 'human.dart';
import 'life_step.dart';

class LifeRoad extends StatelessWidget {
  LifeRoad(
    this._entity,
    this._size, {
    List<Human> humans,
    Map<String, Position> positionsByHumanId,
    Key key,
  })  : _humans = humans ?? [],
        _positionsByHumanId = positionsByHumanId ?? {},
        super(key: key);

  final LifeRoadEntity _entity;

  final List<Human> _humans;
  final Map<String, Position> _positionsByHumanId;

  final Size _size;

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
          _entity.height,
          (y) => TableRow(
            children: List.generate(
              _entity.width,
              (x) => TableCell(
                child: SizedBox(
                  width: _size.width / _entity.width,
                  height: _size.height / _entity.height,
                  child: _lifeStep(_entity.lifeStepsOnBoard[y][x], _putTargetHumans(x, y)),
                ),
              ),
            ),
          ),
        ),
      );

  LifeStep _lifeStep(LifeStepEntity model, List<Human> humans) =>
      model.lifeEvent.type == LifeEventType.nothing ? null : LifeStep(model, humans: humans);
}
