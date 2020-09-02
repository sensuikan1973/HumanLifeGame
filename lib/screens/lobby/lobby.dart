import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/auth.dart';
import '../../api/firestore/store.dart';
import '../../i18n/i18n.dart';
import '../../models/lobby/lobby_notifier.dart';
import '../../router.dart';
import '../play_room/play_room.dart';
import 'app_bar.dart';

class Lobby extends StatelessWidget {
  const Lobby._();

  static Widget inProviders({Key key}) => MultiProvider(
        key: key,
        providers: [
          ChangeNotifierProvider(
            create: (context) => LobbyNotifier(context.read<Auth>(), context.read<Store>()),
          ),
        ],
        child: const Lobby._(),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const LobbyAppBar(),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 450,
                height: 90,
                child: _makeRoomButton(context),
              ),
              SizedBox(
                width: 450,
                height: 90,
                child: _joinRoomButton(context),
              ),
            ],
          ),
        ),
      );

  RaisedButton _makeRoomButton(BuildContext context) => RaisedButton(
        color: Colors.blue[200],
        shape: const StadiumBorder(),
        onPressed: () async {
          final notifier = context.read<LobbyNotifier>();
          await notifier.createPublicPlayRoom();
          await Navigator.of(context).pushNamed(
            context.read<AppRouter>().playRoom,
            arguments: PlayRoomNavigateArguments(notifier.value.haveCreatedPlayRoom),
          );
        },
        child: Text(I18n.of(context).makeRoomButtonText),
      );

  RaisedButton _joinRoomButton(BuildContext context) => RaisedButton(
        color: Colors.blue[200],
        shape: const StadiumBorder(),
        onPressed: () {},
        child: Text(I18n.of(context).joinRoomButtonText),
      );
}
