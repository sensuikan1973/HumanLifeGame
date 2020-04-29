import 'package:HumanLifeGame/domain/play_room/dice_result.dart';
import 'package:HumanLifeGame/domain/play_room/play_room.dart';
import 'package:HumanLifeGame/domain/play_room/player_action.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayRoom', () {
    testWidgets('show PlayerAction and DiceResult', (tester) async {
      await tester.pumpWidget(_PlayRoom());
      await tester.pump();
      expect(find.byType(PlayerAction), findsOneWidget);
      expect(find.byType(DiceResult), findsOneWidget);
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
