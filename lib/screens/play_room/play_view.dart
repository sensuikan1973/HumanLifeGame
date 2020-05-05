import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';
import '../common/life_road.dart';

class PlayView extends StatelessWidget {
  const PlayView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 1050,
        height: 700,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
          ),
          child: Center(
            child: LifeRoad(Provider.of<PlayRoomModel>(context, listen: false).humanLife.lifeRoad),
          ),
        ),
      );
}
