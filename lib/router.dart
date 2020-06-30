import 'package:flutter/material.dart';

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
      final args = settings.arguments as PlayRoomNavigateArguments;
      return MaterialPageRoute<PlayRoom>(
        builder: (context) => PlayRoom.inProviders(playRoomDoc: args.playRoomDoc),
      );
    }

    assert(false, 'Need to implement ${settings.name}');
    return null;
  }
}
