import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');

  group('LifeStep', () {
    testWidgets('show DecoratedBox with Colors.cyan[50]', (tester) async {
      final model = LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem);
      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model, 1050, 700)));
      await tester.pump();

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is DecoratedBox &&
                widget.decoration ==
                    BoxDecoration(
                      color: Colors.cyan[50],
                    ),
          ),
          findsOneWidget);
    });

    testWidgets('show DecoratedBox with Colors.amber[50]', (tester) async {
      final model = LifeEventModel(LifeEventTarget.myself, LifeEventType.nothing);
      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model, 1050, 700)));
      await tester.pump();

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is DecoratedBox &&
                widget.decoration ==
                    BoxDecoration(
                      color: Colors.amber[50],
                    ),
          ),
          findsOneWidget);
    });
  });
}
