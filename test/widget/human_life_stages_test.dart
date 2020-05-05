import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

void main() {
  group('HumanLifeStages', () {
    testWidgets("show 'user id' text", (tester) async {
      await tester.pumpWidget(testableApp(home: const LifeStages()));
      await tester.pump();
      expect(find.text('human 1'), findsOneWidget);
      expect(find.text('human 2'), findsOneWidget);
      expect(find.text('human 3'), findsOneWidget);
      expect(find.text('human 4'), findsOneWidget);
    });
  });
}
