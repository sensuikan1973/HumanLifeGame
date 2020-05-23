import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/play_room/life_event_records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  final i18n = await I18n.load(const Locale('en', 'US'));
  testWidgets("show 'lifeEventRecords'Text", (tester) async {
    await tester.pumpWidget(testableApp(home: const LifeEventRecords()));
    await tester.pump();

    // FIXME : 仮のテキストを表示
    //for (var i = 0; i < 10; ++i) {
    //  expect(find.text('$I18n.of(context).lifeEventRecordsText : $i'), findsOneWidget);
    //}
  });
}
