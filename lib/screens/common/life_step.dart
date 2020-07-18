import 'package:flutter/material.dart';

import '../../entities/life_event_emotion_category.dart';
import '../../entities/life_event_notice_category.dart';
import '../../entities/life_step_entity.dart';
import 'human.dart';

class LifeStep extends StatelessWidget {
  LifeStep(
    this._model, {
    List<Human> humans,
    Key key,
  })  : _humans = humans ?? [],
        super(key: key);

  final LifeStepEntity _model;

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
              child: Row(
                children: [
                  for (final category in _model.lifeEvent.infoCategories) _infoCategoryIcon(category),
                ],
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

  Icon _infoCategoryIcon(LifeEventNoticeCategory category) {
    switch (category) {
      case LifeEventNoticeCategory.job:
        return const Icon(Icons.work, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.stock:
        return const Icon(Icons.trending_up, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.spouse:
        return const Icon(Icons.person, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.house:
        return const Icon(Icons.home, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.money:
        return const Icon(Icons.attach_money, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.vehicle:
        return const Icon(Icons.directions_car, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.child:
        return const Icon(Icons.child_care, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.insurance:
        return const Icon(Icons.security, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.coffee:
        return const Icon(Icons.free_breakfast, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.exchange:
        return const Icon(Icons.swap_horiz, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.selectDirection:
        return const Icon(Icons.directions, color: Colors.black38, size: 20);
      case LifeEventNoticeCategory.nothing:
        return const Icon(null, color: Colors.black38, size: 20);
    }
    return const Icon(null, color: Colors.black38, size: 20);
  }

  Color _emotionCategoryColor(LifeEventEmotionCategory category) {
    switch (category) {
      case LifeEventEmotionCategory.positive:
        return positive;
      case LifeEventEmotionCategory.negative:
        return negative;
      case LifeEventEmotionCategory.normal:
        return normal;
      case LifeEventEmotionCategory.challenge:
        return challenge;
    }
    return null;
  }
}
