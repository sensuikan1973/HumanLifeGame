import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const windowWidth = 1440.0;
  const windowHeight = 1024.0;
  const size = Size(windowWidth, windowHeight);
  setUp(() {
    // See: https://github.com/flutter/flutter/issues/12994#issuecomment-397321431
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: size);
  });
  group('HumanLifeGameApp', () {
    testWidgets('show PlayRoom', (tester) async {
      await tester.pumpWidget(HumanLifeGameApp());
      await tester.pump();
      expect(find.byType(PlayRoom), findsOneWidget);
    });
  });
}
