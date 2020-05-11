import 'dart:ui';

import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);
  final orderedHumans = [HumanModel(id: 'h1', name: 'foo'), HumanModel(id: 'h2', name: 'bar')];
  final humanLife = HumanLifeModel(
    title: 'dummy HumanLife',
    author: UserModel(id: 'dummyUserId', name: 'dummyUser'),
    lifeRoad: LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createDummyLifeStepsOnBoard()),
  );

  testWidgets("show 'Roll the Dice' text", (tester) async {
    final playRoomModel = PlayRoomModel(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const PlayerAction()),
    ));
    await tester.pump();
    expect(find.text(i18n.rollDice), findsOneWidget);
  });

  testWidgets('show Yes/No Button', (tester) async {
    final playRoomModel = PlayRoomModel(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const PlayerAction()),
    ));
    await tester.pump();
    expect(find.text(i18n.playerActionYes), findsOneWidget);
    expect(find.text(i18n.playerActionNo), findsOneWidget);
  });

  testWidgets('show Direction Select Button', (tester) async {
    final playRoomModel = PlayRoomModel(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const PlayerAction()),
    ));
    await tester.pump();
    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
  });
}
