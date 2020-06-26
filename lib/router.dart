import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/dice.dart';
import 'i18n/i18n.dart';
import 'models/common/human.dart';
import 'models/common/life_road.dart';
import 'models/play_room/play_room_notifier.dart';
import 'screens/lobby/lobby.dart';
import 'screens/maintenance/maintenance.dart';
import 'screens/play_room/play_room.dart';
import 'screens/sign_in/sign_in.dart';

@immutable
class Router {
  const Router();

  String get lobby => '/lobby';
  String get signIn => '/sign_in';
  String get playRoom => '/play_room';
  String get maintenance => '/maintenance';

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
      // FIXME: ダミーデータを渡して強引に動いてるだけ。argument で受け取るように改修すること。
      return MaterialPageRoute<PlayRoom>(
        builder: (context) => ChangeNotifierProvider<PlayRoomNotifier>(
          create: (_) => PlayRoomNotifier(
            I18n.of(context),
            context.read<Dice>(),
            LifeRoadModel(
              title: 'dummy HumanLife',
              lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
                LifeRoadModel.dummyLifeEvents(),
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
