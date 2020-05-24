import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_item.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/common/human.dart';
import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../mocks/dice.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  final i18n = await I18n.load(const Locale('en', 'US'));
  final dice = MockDice();
  final humans = [HumanModel(id: 'h1', name: 'foo', order: 0), HumanModel(id: 'h2', name: 'bar', order: 1)];
  final humanLife = HumanLifeModel(
    title: 'dummy HumanLife',
    author: UserModel(id: 'dummyUserId', name: 'dummyUser'),
    lifeRoad: LifeRoadModel(
      lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
        LifeRoadModel.dummyLifeEvents(),
      ),
    ),
  );

  testWidgets('show initial total moneys', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    expect(find.text('0'), findsNWidgets(playRoomModel.lifeStages.length));
  });

  testWidgets('show variable total moneys', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
    for (final lifeStage in playRoomModel.lifeStages) {
      lifeStage.lifeItems.add(LifeItemModel('key', LifeItemType.money, 200));
    }
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    expect(find.text('200'), findsNWidgets(playRoomModel.lifeStages.length));
  });

  testWidgets('show current player', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    final currentPlayerSelector = find.byIcon(Icons.chevron_right);
    final row = tester.element(currentPlayerSelector).findAncestorWidgetOfExactType<Row>();
    final currentPlayerNameText = find.text(playRoomModel.currentPlayer.name);
    expect(row.children, contains(currentPlayerNameText.evaluate().first.widget));
  });

  testWidgets('show user name', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();
    for (final human in humans) {
      expect(find.text(human.name), findsOneWidget);
    }
  });

  testWidgets('show human icons', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeStages()),
    ));
    await tester.pump();

    for (var i = 0; i < humans.length; ++i) {
      expect(find.byWidget(Human.orderedIcon[i]), findsOneWidget);
    }
  });
}
