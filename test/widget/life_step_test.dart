import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');

  testWidgets('show DecoratedBox with Colors.cyan[50]', (tester) async {
    final model = LifeStepModel(
      id: 0,
      lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem),
      right: null,
      left: null,
      up: null,
      down: null,
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

  await testWidget(LifeEventTarget.myself, LifeEventType.start);

  await testWidget(LifeEventTarget.myself, LifeEventType.goal);

  await testWidget(LifeEventTarget.myself, LifeEventType.selectDirection);

  await testWidget(LifeEventTarget.myself, LifeEventType.gainLifeItem);

  await testWidget(LifeEventTarget.myself, LifeEventType.loseLifeItem);
}

Future<void> testWidget(LifeEventTarget target, LifeEventType type) async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);
  testWidgets('show text for target:$target, type:$type', (tester) async {
    final model = LifeStepModel(
      id: 0,
      lifeEvent: LifeEventModel(target, type),
      right: null,
      left: null,
      up: null,
      down: null,
    );

    await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model, 1050, 700)));
    await tester.pump();

    expect(find.text(i18n.lifeStepEventType(model.lifeEvent.type)), findsOneWidget);
  });
}
