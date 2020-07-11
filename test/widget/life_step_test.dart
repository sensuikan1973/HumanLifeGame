import 'package:HumanLifeGame/api/life_step_entity.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/firestore/life_event_helper.dart';
import 'helper/testable_app.dart';

Future<void> main() async {
  testWidgets('show Card with positive Color', (tester) async {
    final model = LifeStepEntity(id: '0', lifeEvent: gainEvent);
    await tester.pumpWidget(testableApp(home: LifeStep(model)));
    await tester.pump();
    expect(
      find.byWidgetPredicate((widget) => widget is Card && widget.color == LifeStep.positive),
      findsOneWidget,
    );
  });

  testWidgets('show Card with negative Color', (tester) async {
    final model = LifeStepEntity(id: '0', lifeEvent: loseEvent);
    await tester.pumpWidget(testableApp(home: LifeStep(model)));
    await tester.pump();
    expect(
      find.byWidgetPredicate((widget) => widget is Card && widget.color == LifeStep.negative),
      findsOneWidget,
    );
  });

  testWidgets('show Card with normal Color', (tester) async {
    final model = LifeStepEntity(id: '0', lifeEvent: startEvent);
    await tester.pumpWidget(testableApp(home: LifeStep(model)));
    await tester.pump();
    expect(
      find.byWidgetPredicate((widget) => widget is Card && widget.color == LifeStep.normal),
      findsOneWidget,
    );
  });

  testWidgets('show description', (tester) async {
    final model = LifeStepEntity(id: '0', lifeEvent: gainEvent);
    await tester.pumpWidget(testableApp(home: LifeStep(model)));
    await tester.pump();
    expect(find.text(gainEvent.description), findsOneWidget);
  });
}
