import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/lose_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  testWidgets('show Card with positive Color', (tester) async {
    final model = LifeStepModel(
      id: 0,
      lifeEvent: LifeEventModel(
        LifeEventTarget.myself,
        const GainLifeItemsParams(targetItems: []),
      ),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model, 1050, 700)));
    await tester.pump();

    expect(
        find.byWidgetPredicate(
          (widget) => widget is Card && widget.color == LifeStep.positive,
        ),
        findsOneWidget);
  });

  testWidgets('show Card with negative Color', (tester) async {
    final model = LifeStepModel(
      id: 0,
      lifeEvent: LifeEventModel(
        LifeEventTarget.myself,
        const LoseLifeItemsParams(targetItems: []),
      ),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model, 1050, 700)));
    await tester.pump();

    expect(
        find.byWidgetPredicate(
          (widget) => widget is Card && widget.color == LifeStep.negative,
        ),
        findsOneWidget);
  });

  testWidgets('show Card with normal Color', (tester) async {
    final model = LifeStepModel(
      id: 0,
      lifeEvent: LifeEventModel(
        LifeEventTarget.myself,
        const StartParams(),
      ),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model, 1050, 700)));
    await tester.pump();

    expect(
        find.byWidgetPredicate(
          (widget) => widget is Card && widget.color == LifeStep.normal,
        ),
        findsOneWidget);
  });

  testWidgets('show SizedBox when NotiongParams', (tester) async {
    final model = LifeStepModel(
      id: 0,
      lifeEvent: LifeEventModel(LifeEventTarget.myself, const NothingParams()),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model, 1050, 700)));
    await tester.pump();

    expect(find.byType(SizedBox), findsOneWidget);
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('show description', (tester) async {
    final model = LifeStepModel(
      id: 0,
      lifeEvent: LifeEventModel(
        LifeEventTarget.myself,
        const GainLifeItemsParams(targetItems: []),
        description: '３年連続皆勤賞の快挙達成！！！',
      ),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model, 1050, 700)));
    await tester.pump();

    expect(find.text('３年連続皆勤賞の快挙達成！！！'), findsOneWidget);
  });
}
