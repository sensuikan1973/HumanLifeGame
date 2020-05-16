import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../helper/life_steps_on_board_helper.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);
  final orderedHumans = [HumanModel(id: 'h1', name: 'foo'), HumanModel(id: 'h2', name: 'bar')];

  final start = LifeEventModel(LifeEventTarget.myself, const StartParams());
  final goals = LifeEventModel(LifeEventTarget.myself, const GoalParams());
  final blank = LifeEventModel(LifeEventTarget.myself, const NothingParams());

  testWidgets("show 'Roll the Dice' text", (tester) async {
    final lifeEvents = [
      [start, blank, goals],
      [blank, blank, blank],
      [blank, blank, blank],
    ];
    final humanLife = HumanLifeModel(
      title: 'dummy HumanLife',
      author: UserModel(id: 'dummyUserId', name: 'dummyUser'),
      lifeRoad: LifeRoadModel(lifeStepsOnBoard: createDummyLifeStepsOnBoard(lifeEvents)),
    );
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(testableApp(
      locale: locale,
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const PlayerAction()),
    ));
    await tester.pump();
    expect(find.text(i18n.rollDice), findsOneWidget);
  });
}
