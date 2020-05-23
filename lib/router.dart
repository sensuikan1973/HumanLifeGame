import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/dice.dart';
import 'i18n/i18n.dart';
import 'models/common/human.dart';
import 'models/common/human_life.dart';
import 'models/common/life_road.dart';
import 'models/common/user.dart';
import 'models/play_room/play_room.dart';
import 'models/play_room/player_action.dart';
import 'screens/play_room/play_room.dart';

class Router {
  final String initialRoute = '/';

  final Map<String, WidgetBuilder> routes = {
//    '/': (context) => SignIn(),
    '/': (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => PlayerActionNotifier(context.read<Dice>()),
            ),
            ChangeNotifierProxyProvider<PlayerActionNotifier, PlayRoomNotifier>(
              create: (_) => PlayRoomNotifier(
                I18n.of(context),
                // FIXME: Repository から取ってくる
                HumanLifeModel(
                  title: 'dummy HumanLife',
                  author: UserModel(id: '123', name: 'dummyUser'),
                  lifeRoad: LifeRoadModel(
                    lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
                      LifeRoadModel.dummyLifeEvents(),
                    ),
                  ),
                ),
                orderedHumans: [
                  HumanModel(id: '1', name: 'hoge', icon: Colors.red[200]),
                  HumanModel(id: '2', name: 'fuga', icon: Colors.blue[200])
                ],
              ),
              update: (context, playerActionNotifier, playRoomNotifier) =>
                  playRoomNotifier..update(playerActionNotifier),
            )
          ],
          child: const PlayRoom(),
        ),
  };
}
