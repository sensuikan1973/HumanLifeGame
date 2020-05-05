import 'package:flutter/material.dart';

import '../../i18n/i18n.dart';
import '../../models/common/life_event.dart';
import '../../models/common/life_road.dart';
import '../../models/common/life_step.dart';
import '../play_room/human.dart';

class LifeStep extends StatelessWidget {
  LifeStep(
    this._model,
    this._width,
    this._height, {
    List<Human> humans,
    Key key,
  })  : _humans = humans ?? [],
        super(key: key);

  final LifeStepModel _model;
  final double _width;
  final double _height;
  final List<Human> _humans;

  @visibleForTesting
  static Color nothing = Colors.amber[50];

  @visibleForTesting
  static Color exist = Colors.cyan[50];

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          SizedBox(
            width: _width / LifeRoadModel.width,
            height: _height / LifeRoadModel.height,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _model.lifeEvent.type == LifeEventType.nothing ? nothing : exist,
                ),
              ),
            ),
          ),
          for (var i = 0; i < _humans.length; ++i)
            // FIXME: 雑に四隅に配置してる
            Positioned(
              top: i == 0 || i == 1 ? 0 : null,
              bottom: i == 2 || i == 3 ? 0 : null,
              left: i == 0 || i == 3 ? 0 : null,
              right: i == 1 || i == 4 ? 0 : null,
              child: _humans[i],
            ),
          Text(I18n.of(context).lifeStepEventType(_model.lifeEvent.type)),
        ],
      );
}
