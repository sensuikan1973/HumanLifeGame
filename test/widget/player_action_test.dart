import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);

  testWidgets("show 'Roll the Dice' text", (tester) async {
    await tester.pumpWidget(testableApp(locale: locale, home: const PlayerAction()));
    await tester.pump();
    expect(find.text(i18n.rollDice), findsOneWidget);
  });

  testWidgets('show two-Choice Button', (tester) async {
    await tester.pumpWidget(testableApp(locale: locale, home: const PlayerAction()));
    await tester.pump();
    expect(find.text(i18n.playerActionYes), findsOneWidget);
    expect(find.text(i18n.playerActionNo), findsOneWidget);
  });

  testWidgets('show Direction Select Button', (tester) async {
    await tester.pumpWidget(testableApp(locale: locale, home: const PlayerAction()));
    await tester.pump();
    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
  });
}
