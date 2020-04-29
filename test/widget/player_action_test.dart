import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerAction', () {
    testWidgets("show 'start' text", (tester) async {
      await tester.pumpWidget(_PlayerAction());
      await tester.pump();
      expect(find.text('Roll the dice'), findsOneWidget);
    });
  });
}

class _PlayerAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Test App For PlayerAction',
        localizationsDelegates: const [I18nDelegate()],
        supportedLocales: const [Locale('en', 'US')],
        locale: const Locale('en'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlayerAction(),
      );
}
