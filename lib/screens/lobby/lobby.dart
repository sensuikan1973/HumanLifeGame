import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/auth.dart';
import '../../api/firestore/store.dart';
import '../../models/common/user.dart';
import '../../models/lobby/lobby_notifier.dart';
import 'app_bar.dart';
import 'human_life_tips.dart';
import 'room_list_item.dart';

class Lobby extends StatelessWidget {
  const Lobby._();

  static Widget inProviders({Key key}) => MultiProvider(
        key: key,
        providers: [
          Provider(
            create: (context) => LobbyNotifier(context.read<Auth>(), context.read<Store>()),
          ),
        ],
        child: const Lobby._(),
      );

  Future<UserModel> _signIn(Auth auth) async {
    final user = await auth.currentUser;
    if (user != null) return user;
    if (kDebugMode) return auth.signInForDebug();
    return auth.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const LobbyAppBar(),
        body: Center(
          child: FutureBuilder<UserModel>(
            future: _signIn(context.watch<Auth>()),
            builder: (context, snap) {
              if (snap.hasError) return const Text('Oops');
              if (snap.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
              if (snap.hasData) {
                return Row(
                  children: [
                    Stack(
                      children: [
                        _roomList(),
                        Positioned(bottom: 0, right: 0, child: _createRoomButton(context)),
                      ],
                    ),
                    const HumanLifeTips(),
                  ],
                );
              }
              return const Text('You must sign in');
            },
          ),
        ),
      );

  FloatingActionButton _createRoomButton(BuildContext context) => FloatingActionButton(
        tooltip: 'create public PlayRoom',
        backgroundColor: Colors.indigo,
        onPressed: () async => context.read<LobbyNotifier>().createPublicPlayRoom(),
        child: const Icon(Icons.add),
      );

  SizedBox _roomList() => SizedBox(
        width: 720,
        height: 970,
        child: ListView(
          children: const [
            RoomListItem(),
            RoomListItem(),
            RoomListItem(),
            RoomListItem(),
          ],
        ),
      );
}
