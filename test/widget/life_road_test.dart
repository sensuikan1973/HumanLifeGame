import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final model = LifeRoadModel(
    lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
      LifeRoadModel.dummyLifeEvents(),
    ),
  );
  testWidgets('show LifeStep', (tester) async {
    await tester.pumpWidget(testableApp(locale: locale, home: LifeRoad(model)));
    await tester.pump();
    expect(find.byType(LifeStep), findsNWidgets(model.width * model.height));
  });
}
