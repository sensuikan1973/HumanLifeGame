import 'package:HumanLifeGame/domain/play_room/human_life_stages.dart';
import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HumanLifeStages', () {
    testWidgets("show 'user id' text", (tester) async {
      await tester.pumpWidget(_HumanLifeStages());
      await tester.pump();
      expect(find.text('human 1'), findsOneWidget);
      expect(find.text('human 2'), findsOneWidget);
      expect(find.text('human 3'), findsOneWidget);
      expect(find.text('human 4'), findsOneWidget);
    });
  });
}

class _HumanLifeStages extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Test App For HumanLifeStages',
        localizationsDelegates: const [I18nDelegate()],
        supportedLocales: const [Locale('en', 'US')],
        locale: const Locale('en'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HumanLifeStages(),
      );
}
