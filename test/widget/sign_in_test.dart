import 'package:HumanLifeGame/api/auth.dart';
import 'package:HumanLifeGame/screens/sign_in/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks/auth.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  testWidgets('not signed in', (tester) async {
    final auth = MockAuth();
    when(auth.currentUserStream).thenAnswer((_) => Stream.fromIterable([null]));
    await tester.pumpWidget(testableApp(
      home: Provider<Auth>(create: (_) => auth, child: const SignIn()),
    ));
    await tester.pump();
    expect(find.byType(SignIn), findsOneWidget);
  });

  testWidgets('already signed in', (tester) async {
    final user = MockFirebaseUser();
    final auth = MockAuth();
    when(auth.currentUserStream).thenAnswer((_) => Stream.fromIterable([user]));
    await tester.pumpWidget(testableApp(
      home: Provider<Auth>(create: (_) => auth, child: const SignIn()),
    ));
    await tester.pump(); // currentUserStream の initialData(つまり null)が流れる
    await tester.pump(); // currentUserStream の次の値(つまり user)が流れる
    expect(find.text('current id: ${user.uid}'), findsOneWidget);
  });
}
