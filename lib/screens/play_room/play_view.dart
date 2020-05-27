import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';
import '../../models/play_room/play_room_state.dart';
import '../common/human.dart';
import '../common/life_road.dart';

class PlayView extends StatelessWidget {
  const PlayView({Key key}) : super(key: key);

  Size get _desktopSize => const Size(1440, 1024);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final playRoomState = context.watch<PlayRoomNotifier>().value;

    final lifeStepSize = Size(
      screenSize.width >= _desktopSize.width ? 150 : 130,
      100,
    );
    final lifeRoadSize = Size(
      lifeStepSize.width * playRoomState.humanLife.lifeRoad.width,
      lifeStepSize.height * playRoomState.humanLife.lifeRoad.height,
    );

    return LayoutBuilder(
        builder: (context, constraints) => Card(
              child: ColoredBox(
                color: Colors.blue[50],
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      child: Image.asset(
                        'images/play_view_background.jpg',
                        //height: _height,
                        height: constraints.maxHeight,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    _playView(playRoomState, lifeRoadSize),
                  ],
                ),
              ),
            ));
  }

  CustomScrollView _playView(PlayRoomState playRoomState, Size lifeRoadSize) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: lifeRoadSize.height,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverToBoxAdapter(
                    child: _lifeRoad(playRoomState, lifeRoadSize),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  LifeRoad _lifeRoad(PlayRoomState playRoomState, Size size) => LifeRoad(
        playRoomState.humanLife.lifeRoad,
        size.width,
        size.height,
        humans: [
          for (final humanModel in playRoomState.orderedHumans) Human(humanModel),
        ],
        positionsByHumanId: playRoomState.positionsByHumanId,
      );
}
