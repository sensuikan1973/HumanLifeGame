import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/play_room/life_event_records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);
  group('LifeEventRecords', () {
    testWidgets("show 'lifeEventRecords'Text", (tester) async {
      await tester.pumpWidget(testableApp(locale: locale, home: const LifeEventRecords()));
      await tester.pump();

      expect(find.text(i18n.lifeEventRecordsText), findsOneWidget);
    });
  });
}
