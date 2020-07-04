import 'package:HumanLifeGame/api/firestore/life_event.dart';
import 'package:HumanLifeGame/entities/life_step_entity.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/life_event_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/lose_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/testable_app.dart';

Future<void> main() async {
  testWidgets('show Card with positive Color', (tester) async {
    final model = LifeStepEntity(
      id: 0,
      lifeEvent: const LifeEventEntity<GainLifeItemsParams>(
        target: LifeEventTarget.myself,
        params: GainLifeItemsParams(targetItems: []),
        type: LifeEventType.gainLifeItems,
      ),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model)));
    await tester.pump();

    expect(
      find.byWidgetPredicate((widget) => widget is Card && widget.color == LifeStep.positive),
      findsOneWidget,
    );
  });

  testWidgets('show Card with negative Color', (tester) async {
    final model = LifeStepEntity(
      id: 0,
      lifeEvent: const LifeEventEntity<LoseLifeItemsParams>(
        target: LifeEventTarget.myself,
        params: LoseLifeItemsParams(targetItems: []),
        type: LifeEventType.gainLifeItems,
      ),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model)));
    await tester.pump();

    expect(
      find.byWidgetPredicate((widget) => widget is Card && widget.color == LifeStep.negative),
      findsOneWidget,
    );
  });

  testWidgets('show Card with normal Color', (tester) async {
    final model = LifeStepEntity(
      id: 0,
      lifeEvent: const LifeEventEntity<StartParams>(
        target: LifeEventTarget.myself,
        params: StartParams(),
        type: LifeEventType.gainLifeItems,
      ),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model)));
    await tester.pump();

    expect(
      find.byWidgetPredicate((widget) => widget is Card && widget.color == LifeStep.normal),
      findsOneWidget,
    );
  });

  testWidgets('show description', (tester) async {
    const gainEvent = LifeEventEntity<GainLifeItemsParams>(
      target: LifeEventTarget.myself,
      params: GainLifeItemsParams(targetItems: []),
      type: LifeEventType.gainLifeItems,
    );
    final model = LifeStepEntity(id: 0, lifeEvent: gainEvent);

    await tester.pumpWidget(testableApp(home: LifeStep(model)));
    await tester.pump();

    expect(find.text(gainEvent.description), findsOneWidget);
  });
}
