import 'package:HumanLifeGame/api/dice.dart';
import 'package:HumanLifeGame/screens/play_room/announcement.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/human_life.dart';
import 'package:HumanLifeGame/screens/play_room/human_life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks/mocks.dart';
import 'helper/widget_build_helper.dart';

void main() {
  group('PlayRoom', () {
    testWidgets('show some widgets', (tester) async {
      await tester.pumpWidget(
        Provider(create: (context) => const Dice(), child: testableApp(home: PlayRoom())),
      );
      await tester.pump();
      expect(find.byType(PlayerAction), findsOneWidget);
      expect(find.byType(DiceResult), findsOneWidget);
      expect(find.byType(HumanLifeStages), findsOneWidget);
      expect(find.byType(Announcement), findsOneWidget);
      expect(find.byType(HumanLife), findsOneWidget);
    });

    testWidgets('random value(1 <= value <= 6) should be displayed when dice is rolled', (tester) async {
      final dice = MockDice();
      when(dice.roll()).thenReturn(5);
      await tester.pumpWidget(
        Provider<Dice>(create: (context) => dice, child: testableApp(home: PlayRoom())),
      );
      await tester.pump();

      await tester.tap(find.byKey(const Key('playerActionDiceRollButton')));
      await tester.pump();
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('show Announcement message when dice is rolled', (tester) async {
      final dice = MockDice();
      when(dice.roll()).thenReturn(5);
      await tester.pumpWidget(
        Provider<Dice>(create: (context) => dice, child: testableApp(home: PlayRoom())),
      );
      await tester.pump();

      await tester.tap(find.byKey(const Key('playerActionDiceRollButton')));
      await tester.pump();
      expect(find.text('result: 5'), findsOneWidget);
    });
  });
}
