import 'package:HumanLifeGame/models/player_action.dart';
import 'package:HumanLifeGame/screens/play_room/announcement.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/human_life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

void main() {
  group('PlayRoom', () {
    testWidgets('show some widgets', (tester) async {
      await tester.pumpWidget(testableApp(home: PlayRoom()));
      await tester.pump();
      expect(find.byType(PlayerAction), findsOneWidget);
      expect(find.byType(DiceResult), findsOneWidget);
      expect(find.byType(HumanLifeStages), findsOneWidget);
      expect(find.byType(Announcement), findsOneWidget);
    });

    testWidgets('random value(1 <= value <= 6) should be displayed when dice is rolled', (tester) async {
      const diceResultText = Key('diceResultText');
      const rollDiceButton = Key('playerActionDiceRollButton');
      await tester.pumpWidget(testableApp(home: PlayRoom()));
      await tester.pump();

      await tester.tap(find.byKey(rollDiceButton));
      await tester.pump();
      final text = find.byKey(diceResultText).evaluate().first.widget as Text;
      expect(num.parse(text.data), inInclusiveRange(1, PlayerActionModel.maxDiceNumber));
    });

    testWidgets('show Announcement message when dice is rolled', (tester) async {
      await tester.pumpWidget(testableApp(home: PlayRoom()));
      await tester.pump();

      await tester.tap(find.byKey(const Key('playerActionDiceRollButton')));
      await tester.pump();
      final text = find.byKey(const Key('announcementMessageText')).evaluate().first.widget as Text;
      expect(text.data.isNotEmpty, true); // TODO: もうちょっとちゃんとしたテストに
    });
  });
}
