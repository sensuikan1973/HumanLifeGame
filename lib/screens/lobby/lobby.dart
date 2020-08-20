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
import 'human_life_tips.dart';
import 'room_list_item.dart';

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
            children: [
              Stack(
                children: [
                  _roomList(context),
                  Positioned(bottom: 0, right: 0, child: _createRoomButton(context)),
                ],
              ),
              const LifeRoadTips(),
            ],
          ),
        ),
      );

  FloatingActionButton _createRoomButton(BuildContext context) => FloatingActionButton(
        tooltip: I18n.of(context).lobbyCreatePublicRoomButtonTooltip,
        backgroundColor: Colors.indigo,
        onPressed: () async {
          final notifier = context.read<LobbyNotifier>();
          await notifier.createPublicPlayRoom();
          await Navigator.of(context).pushNamed(
            context.read<AppRouter>().playRoom,
            arguments: PlayRoomNavigateArguments(notifier.value.haveCreatedPlayRoom),
          );
        },
        child: const Icon(Icons.add),
      );

  SizedBox _roomList(BuildContext context) {
    final rooms = context.watch<LobbyNotifier>().value.publicPlayRooms;
    return SizedBox(
      width: 720,
      height: 970,
      child: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) => RoomListItem(rooms[index]),
      ),
    );
  }
}
