import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:HumanLifeGame/screens/play_room/life_road.dart';
import 'package:HumanLifeGame/screens/play_room/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LifeRoad', () {
    testWidgets("show 'LifeStep'", (tester) async {
      await tester.pumpWidget(_LifeRoad());
      await tester.pump();
      expect(find.byType(LifeStep), findsOneWidget);
    });
  });
}

class _LifeRoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Test App For LifeRoad',
        localizationsDelegates: const [I18nDelegate()],
        supportedLocales: const [Locale('en', 'US')],
        locale: const Locale('en'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LifeRoad(),
      );
}
