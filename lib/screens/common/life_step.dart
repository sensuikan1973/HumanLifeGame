import 'package:flutter/material.dart';

import '../../i18n/i18n.dart';
import '../../models/common/life_event_params/life_event_params.dart';
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
          Text(I18n.of(context).lifeStepEventType(_model.lifeEvent.type)),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: _humans),
            ),
          ),
        ],
      );
}
