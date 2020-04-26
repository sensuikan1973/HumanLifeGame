import 'package:flutter_test/flutter_test.dart';
import 'package:HumanLifeGameGenerator/human_life_game_app.dart';

void main() {
  testWidgets('dummy text', (tester) async {
    await tester.pumpWidget(HumanLifeGameApp());
    expect(find.text('foo'), findsOneWidget);
  });
}
