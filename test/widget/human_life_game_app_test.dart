import 'package:HumanLifeGame/domain/play_room/play_room.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HumanLifeGameApp', () {
    testWidgets('show PlayRoom', (tester) async {
      await tester.pumpWidget(HumanLifeGameApp());
      await tester.pump();
      expect(find.byType(PlayRoom), findsOneWidget);
    });
  });
}
