import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/dice.dart';
import 'i18n/i18n.dart';
import 'models/common/human.dart';
import 'models/common/human_life.dart';
import 'models/common/life_road.dart';
import 'models/common/user.dart';
import 'models/play_room/play_room_notifier.dart';
import 'screens/lobby/lobby.dart';
import 'screens/maintenance/maintenance.dart';
import 'screens/play_room/play_room.dart';
import 'screens/sign_in/sign_in.dart';

@immutable
class Router {
  final String lobby = '/lobby';
  final String signIn = '/sign_in';
  final String playRoom = '/play_room';
  final String maintenance = '/maintenance';

  Route<dynamic> generateRoutes(RouteSettings settings) {
    final name = settings.name;
    if (name == lobby) {
      return MaterialPageRoute<Lobby>(builder: (_) => Lobby.inProviders());
    }
    if (name == signIn) {
      return MaterialPageRoute<SignIn>(builder: (_) => const SignIn());
    }
    if (name == maintenance) {
      return MaterialPageRoute<Maintenance>(builder: (_) => const Maintenance());
    }
    if (name == playRoom) {
      return MaterialPageRoute<PlayRoom>(
        builder: (context) => ChangeNotifierProvider<PlayRoomNotifier>(
          create: (_) => PlayRoomNotifier(
            I18n.of(context),
            context.read<Dice>(),
            HumanLifeModel(
              title: 'dummy HumanLife',
              author: UserModel(id: '123', name: 'dummyUser', isAnonymous: true),
              lifeRoad: LifeRoadModel(
                lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
                  LifeRoadModel.dummyLifeEvents(),
                ),
              ),
            ),
            [
              const HumanModel(id: '1', name: 'hoge', order: 0),
              const HumanModel(id: '2', name: 'fuga', order: 1),
            ],
          ),
          child: const PlayRoom(),
        ),
      );
    }

    assert(false, 'Need to implement ${settings.name}');
    return null;
  }
}
