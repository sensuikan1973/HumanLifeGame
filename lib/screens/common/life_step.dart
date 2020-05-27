import 'package:flutter/material.dart';

import '../../models/common/life_event_params/life_event_params.dart';
import '../../models/common/life_step.dart';
import 'human.dart';

class LifeStep extends StatelessWidget {
  LifeStep(
    this._model, {
    List<Human> humans,
    Key key,
  })  : _humans = humans ?? [],
        super(key: key);

  final LifeStepModel _model;

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
  Widget build(BuildContext context) => Card(
        color: _emotionCategoryColor(_model.lifeEvent.emotionCategory),
        elevation: 4,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 70,
              child: Center(
                child: Text(_model.lifeEvent.description),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    for (final category in _model.lifeEvent.infoCategories) _infoCategoryIcon(category),
                  ],
                ),
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
      );

  Icon _infoCategoryIcon(InfoCategory category) {
    switch (category) {
      case InfoCategory.job:
        return const Icon(Icons.work, color: Colors.black38, size: 20);
      case InfoCategory.stock:
        return const Icon(Icons.trending_up, color: Colors.black38, size: 20);
      case InfoCategory.spouse:
        return const Icon(Icons.person, color: Colors.black38, size: 20);
      case InfoCategory.house:
        return const Icon(Icons.home, color: Colors.black38, size: 20);
      case InfoCategory.money:
        return const Icon(Icons.attach_money, color: Colors.black38, size: 20);
      case InfoCategory.vehicle:
        return const Icon(Icons.directions_car, color: Colors.black38, size: 20);
      case InfoCategory.child:
        return const Icon(Icons.child_care, color: Colors.black38, size: 20);
      case InfoCategory.insurance:
        return const Icon(Icons.security, color: Colors.black38, size: 20);
      case InfoCategory.coffee:
        return const Icon(Icons.free_breakfast, color: Colors.black38, size: 20);
      case InfoCategory.exchange:
        return const Icon(Icons.swap_horiz, color: Colors.black38, size: 20);
      case InfoCategory.selectDirection:
        return const Icon(Icons.directions, color: Colors.black38, size: 20);
      case InfoCategory.nothing:
        return const Icon(null, color: Colors.black38, size: 20);
    }
    return const Icon(null, color: Colors.black38, size: 20);
  }

  Color _emotionCategoryColor(EmotionCategory category) {
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
