import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/human_life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayRoom', () {
    testWidgets('show PlayerAction, DiceResult and HumanInfo', (tester) async {
      await tester.pumpWidget(_PlayRoom());
      await tester.pump();
      expect(find.byType(PlayerAction), findsOneWidget);
      expect(find.byType(DiceResult), findsOneWidget);
      expect(find.byType(HumanLifeStages), findsOneWidget);
    });
    testWidgets('random value(1 <= value <= 6) should be displayed in disc_result when start button is tapped',
        (tester) async {
      const diceResultText = Key('dice-result-text');
      const rollDiceButton = Key('player-action-dice-roll-button');
      await tester.pumpWidget(_PlayRoom());
      await tester.pump();

      await tester.tap(find.byKey(rollDiceButton));
      await tester.pump();
      final text = find.byKey(diceResultText).evaluate().first.widget as Text;
      expect(num.parse(text.data), inInclusiveRange(1, 6));
    });
  });
}

class _PlayRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Test App For PlayRoom',
        localizationsDelegates: const [I18nDelegate()],
        supportedLocales: const [Locale('en', 'US')],
        locale: const Locale('en'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlayRoom(),
      );
}
