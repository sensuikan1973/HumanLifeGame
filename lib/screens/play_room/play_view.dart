import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room_notifier.dart';
import '../../models/play_room/play_room_state.dart';
import '../common/human.dart';
import '../common/life_road.dart';

class PlayView extends StatelessWidget {
  const PlayView({Key key}) : super(key: key);

  String get _backgroundImage => 'images/play_view_background.jpg';
  Size get _desktopSize => const Size(1440, 1024);
  Size _lifeStepSize(BuildContext context) => Size(
        MediaQuery.of(context).size.width >= _desktopSize.width ? 150 : 130,
        100,
      );
  Size _lifeRoadSize(BuildContext context) {
    final playRoomState = context.watch<PlayRoomNotifier>().value;
    return Size(
      _lifeStepSize(context).width * playRoomState.lifeRoad.entity.width,
      _lifeStepSize(context).height * playRoomState.lifeRoad.entity.height,
    );
  }

  @override
  Widget build(BuildContext context) => Card(
        child: ColoredBox(
          color: Colors.blue[50],
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  child: Image.asset(
                    _backgroundImage,
                    height: constraints.maxHeight,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                _playView(context),
              ],
            ),
          ),
        ),
      );

  CustomScrollView _playView(BuildContext context) {
    final playRoomState = context.watch<PlayRoomNotifier>().value;
    final lifeRoadSize = _lifeRoadSize(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: lifeRoadSize.height,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: lifeRoadSize.width,
                    height: lifeRoadSize.height,
                    child: _lifeRoad(playRoomState, lifeRoadSize),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LifeRoad _lifeRoad(PlayRoomState playRoomState, Size size) => LifeRoad(
        playRoomState.lifeRoad.entity,
        size,
        humans: [for (final human in playRoomState.humans) Human(human)],
        positionsByHumanId: playRoomState.positionsByHumanId,
      );
}
