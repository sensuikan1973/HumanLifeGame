import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/life_event_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  testWidgets('show Card with exist item Color', (tester) async {
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
          (widget) => widget is Card && widget.color == LifeStep.exist,
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

  //await checkLifeEventI18n(LifeEventTarget.myself, LifeEventType.start);
//
  //await checkLifeEventI18n(LifeEventTarget.myself, LifeEventType.goal);
//
  //await checkLifeEventI18n(LifeEventTarget.myself, LifeEventType.selectDirection);
//
  //await checkLifeEventI18n(LifeEventTarget.myself, LifeEventType.gainLifeItems);
//
  //await checkLifeEventI18n(LifeEventTarget.myself, LifeEventType.loseLifeItems);
}

Future<void> checkLifeEventI18n(LifeEventTarget target, LifeEventType type) async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);
  testWidgets('show text for target:$target, type:$type', (tester) async {
    final model = LifeStepModel(
      id: 0,
      lifeEvent: LifeEventModel(target, const NothingParams()),
    );

    await tester.pumpWidget(testableApp(home: LifeStep(model, 1050, 700)));
    await tester.pump();

    expect(find.text(i18n.lifeStepEventType(model.lifeEvent.type)), findsOneWidget);
  });
}
