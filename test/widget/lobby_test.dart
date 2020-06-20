import 'package:HumanLifeGame/api/auth.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/screens/lobby/human_life_tips.dart';
import 'package:HumanLifeGame/screens/lobby/lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks/auth.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  setUp(() {
    // See: https://github.com/flutter/flutter/issues/12994#issuecomment-397321431
    // Desktopの標準サイズ 1440x1024に設定
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1440, 1024));
  });
  testWidgets('show some widgets', (tester) async {
    final user = UserModel(id: '123', name: 'foo', isAnonymous: true);
    final auth = MockAuth();
    when(auth.currentUser).thenAnswer((_) async => user);
    await tester.pumpWidget(testableApp(
      home: Provider<Auth>(create: (_) => auth, child: const Lobby()),
    ));
    await tester.pump();
    await tester.pump();
    expect(find.byType(HumanLifeTips), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
