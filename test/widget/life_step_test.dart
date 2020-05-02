import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  group('LifeStep', () {
    testWidgets('show DecoratedBox', (tester) async {
      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep()));
      await tester.pump();
      expect(find.byType(DecoratedBox), findsOneWidget);
    });
  });
}
