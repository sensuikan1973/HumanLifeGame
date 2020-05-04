import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');

  group('LifeStep', () {
    testWidgets('show DecoratedBox', (tester) async {
      final model = LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem);
      await tester.pumpWidget(testableApp(locale: locale, home: LifeStep(model)));
      await tester.pump();
      expect(find.byType(DecoratedBox), findsNWidgets(2));
    });
  });
}
