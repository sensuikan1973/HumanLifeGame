import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/screens/lobby/lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/auth.dart';

void main() {
  // Desktopの標準サイズ 1440x1024に設定
  const size = Size(1440, 1024);
  setUp(() {
    // See: https://github.com/flutter/flutter/issues/12994#issuecomment-397321431
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: size);
  });

  testWidgets('show Lobby', (tester) async {
    await tester.pumpWidget(HumanLifeGameApp.inProviders(
      auth: MockAuth(MockFirebaseUser()),
    ));
    await tester.pump();
    expect(find.byType(Lobby), findsOneWidget);
  });
}
