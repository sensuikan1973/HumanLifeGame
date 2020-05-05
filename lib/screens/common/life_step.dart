import 'package:flutter/material.dart';

import '../../i18n/i18n.dart';
import '../../models/common/life_event.dart';
import '../../models/common/life_road.dart';
import '../../models/common/life_step.dart';

class LifeStep extends StatelessWidget {
  const LifeStep(
    this.model,
    this.width,
    this.height, {
    Key key,
  }) : super(key: key);

  final LifeStepModel model;
  final double width;
  final double height;

  @visibleForTesting
  static Color nothing = Colors.amber[50];

  @visibleForTesting
  static Color exist = Colors.cyan[50];

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          SizedBox(
            width: width / LifeRoadModel.width,
            height: height / LifeRoadModel.height,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: model.lifeEvent.type == LifeEventType.nothing ? nothing : exist,
                ),
              ),
            ),
          ),
          Text(I18n.of(context).lifeStepEventType(model.lifeEvent.type)),
        ],
      );
}
