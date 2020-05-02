import 'package:HumanLifeGame/screens/play_room/life_event_records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  group('LifeEventRecords', () {
    testWidgets("show 'lifeEventRecords'Text", (tester) async {
      const lifeEventRecodesText = Key('lifeEventRecordsText');
      await tester.pumpWidget(testableApp(locale: locale, home: LifeEventRecordes()));
      await tester.pump();
      final text = find.byKey(lifeEventRecodesText).evaluate().first.widget as Text;
      expect(text.data, 'Reserved area:lifeEventRecords');
    });
  });
}
