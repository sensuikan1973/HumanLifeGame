import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);
  group('LifeStep', () {
    testWidgets('show DecoratedBox with Colors.cyan[50]', (tester) async {
      final model = LifeStepModel(
        id: 0,
        lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem),
        right: null,
        left: null,
        up: null,
        down: null,
        isStart: false,
        isGoal: false,
      );

      LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem);
      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model, 1050, 700)));
      await tester.pump();

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is DecoratedBox &&
                widget.decoration ==
                    BoxDecoration(
                      color: LifeStep.exist,
                    ),
          ),
          findsOneWidget);
    });

    testWidgets('show DecoratedBox with Colors.amber[50]', (tester) async {
      final model = LifeStepModel(
        id: 0,
        lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.nothing),
        right: null,
        left: null,
        up: null,
        down: null,
        isStart: false,
        isGoal: false,
      );

      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model, 1050, 700)));
      await tester.pump();

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is DecoratedBox &&
                widget.decoration ==
                    BoxDecoration(
                      color: LifeStep.nothing,
                    ),
          ),
          findsOneWidget);
    });

    testWidgets("show 'Start' text", (tester) async {
      final model = LifeStepModel(
        id: 0,
        lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.start),
        right: null,
        left: null,
        up: null,
        down: null,
        isStart: true,
        isGoal: false,
      );

      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model, 1050, 700)));
      await tester.pump();

      expect(find.text(i18n.lifeStepStartText), findsOneWidget);
    });

    testWidgets("show 'Goal' text", (tester) async {
      final model = LifeStepModel(
        id: 0,
        lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.goal),
        right: null,
        left: null,
        up: null,
        down: null,
        isStart: false,
        isGoal: true,
      );

      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model, 1050, 700)));
      await tester.pump();

      expect(find.text(i18n.lifeStepGoalText), findsOneWidget);
    });

    testWidgets("show 'Gain Item :' text", (tester) async {
      final model = LifeStepModel(
        id: 0,
        lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem),
        right: null,
        left: null,
        up: null,
        down: null,
        isStart: false,
        isGoal: false,
      );

      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model, 1050, 700)));
      await tester.pump();

      expect(find.text(i18n.lifeStepGainItemText), findsOneWidget);
    });
  });
}
