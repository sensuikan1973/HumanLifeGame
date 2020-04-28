import 'package:HumanLifeGame/domain/play_room/dice.dart';
import 'package:HumanLifeGame/domain/play_room/player_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';

void main() {
  testWidgets('player action test', (tester) async {
    await tester.pumpWidget(HumanLifeGameApp());
    await tester.pump();
    expect(find.byType(PlayerAction), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });
  testWidgets('dice test', (tester) async {
    await tester.pumpWidget(HumanLifeGameApp());
    await tester.pump();
    expect(find.byType(Dice), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });
}
