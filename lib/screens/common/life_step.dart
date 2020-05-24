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
  static Color exist = Colors.cyan[50];
  static Color positive = Colors.red[50];
  static Color negative = Colors.blue[50];
  static Color normal = Colors.grey[50];
  static Color challenge = Colors.green[50];

  @override
  Widget build(BuildContext context) => SizedBox(
        width: _width,
        height: _height,
        child: _model.lifeEvent.type == LifeEventType.nothing
            ? null
            : Card(
                color: _eventCategoryColor(_model.lifeEvent.category),
                elevation: 4,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                      child: Center(
                        child: Text(_model.lifeEvent.description),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: _eventCategoryIcon(_model.lifeEvent.category),
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

  Icon _eventCategoryIcon(EventCategory category) {
    switch (category) {
      case EventCategory.positive:
        return Icon(Icons.mood, color: Colors.grey[400], size: 20);
      case EventCategory.negative:
        return Icon(Icons.mood_bad, color: Colors.grey[400], size: 20);
      case EventCategory.normal:
        // TODO: Handle this case.
        break;
      case EventCategory.challenge:
        // TODO: Handle this case.
        break;
    }
    return null;
  }

  Color _eventCategoryColor(EventCategory category) {
    switch (category) {
      case EventCategory.positive:
        return positive;
      case EventCategory.negative:
        return negative;
      case EventCategory.normal:
        return normal;
      case EventCategory.challenge:
        return challenge;
    }
    return null;
  }
}
