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
  static Color positive = Colors.red[50];
  @visibleForTesting
  static Color negative = Colors.blue[50];
  @visibleForTesting
  static Color normal = Colors.grey[50];
  @visibleForTesting
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

  Icon _eventCategoryIcon(EmotionCategory category) {
    switch (category) {
      case EmotionCategory.positive:
        return Icon(Icons.mood, color: Colors.grey[400], size: 20);
      case EmotionCategory.negative:
        return Icon(Icons.mood_bad, color: Colors.grey[400], size: 20);
      case EmotionCategory.normal:
        // TODO: Handle this case.
        break;
      case EmotionCategory.challenge:
        // TODO: Handle this case.
        break;
    }
    return null;
  }

  Color _eventCategoryColor(EmotionCategory category) {
    switch (category) {
      case EmotionCategory.positive:
        return positive;
      case EmotionCategory.negative:
        return negative;
      case EmotionCategory.normal:
        return normal;
      case EmotionCategory.challenge:
        return challenge;
    }
    return null;
  }
}
