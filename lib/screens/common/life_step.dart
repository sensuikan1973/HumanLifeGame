import 'package:flutter/material.dart';

import '../../models/common/life_event_params/life_event_params.dart';
import '../../models/common/life_step.dart';
import 'human.dart';

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
  static Color nothing = Colors.white;

  @visibleForTesting
  static Color exist = Colors.cyan[50];

  @override
  Widget build(BuildContext context) => _model.lifeEvent.type == LifeEventType.nothing
      ? SizedBox(
          width: _width,
          height: _height,
        )
      : SizedBox(
          width: _width,
          height: _height,
          child: Card(
            color: exist,
            elevation: 4,
            child: Stack(
              children: <Widget>[
                SizedBox(
                    width: _width,
                    height: 72,
                    child: Center(
                      child: Text(_model.lifeEvent.description),
                    )),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: _model.lifeEvent.type == LifeEventType.gainLifeItems
                        ? Icon(Icons.mood, color: Colors.grey[400], size: 20)
                        : null,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(children: _humans),
                  ),
                ),
              ],
            ),
          ),
        );
}
