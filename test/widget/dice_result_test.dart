import 'package:HumanLifeGame/domain/play_room/dice_result.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiceResult', () {
    testWidgets("show '2' text", (tester) async {
      await tester.pumpWidget(_DiceResult());
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
    });
  });
}

class _DiceResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Test App For DiceResult',
        localizationsDelegates: const [I18nDelegate()],
        supportedLocales: const [Locale('en', 'US')],
        locale: const Locale('en'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DiceResult(),
      );
}
