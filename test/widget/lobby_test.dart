import 'package:HumanLifeGame/api/auth.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/screens/lobby/create_human_life.dart';
import 'package:HumanLifeGame/screens/lobby/lobby.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks/auth.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  testWidgets('show some widgets', (tester) async {
    final user = UserModel(id: '123', name: 'foo', isAnonymous: true);
    final auth = MockAuth();
    when(auth.currentUserStream).thenAnswer((_) => Stream.fromIterable([user]));
    await tester.pumpWidget(testableApp(
      home: Provider<Auth>(create: (_) => auth, child: const Lobby()),
    ));
    await tester.pump();
    await tester.pump();
    expect(find.byType(CreateHumanLife), findsOneWidget);
  });
}
