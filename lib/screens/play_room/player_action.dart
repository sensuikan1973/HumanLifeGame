import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../i18n/i18n.dart';
import '../../models/common/life_step.dart';
import '../../models/play_room/play_room.dart';
import '../../models/play_room/player_action.dart';

class PlayerAction extends StatelessWidget {
  const PlayerAction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Container(
          width: 300,
          height: 300,
          child: <Widget>[
            if (context.select<PlayRoomNotifier, bool>((value) => value.requireSelectDirection))
              _directionSelectButton(context),
            _rollDiceButton(context),
          ].first, // NOTE: 常に必要な Action UI は 1つ
        ),
      );

  FlatButton _rollDiceButton(BuildContext context) => FlatButton(
        key: const Key('playerActionDiceRollButton'),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: context.select<PlayRoomNotifier, bool>((model) => model.allHumansReachedTheGoal)
            ? null
            : () => context.read<PlayerActionNotifier>().rollDice(),
        child: Text(
          I18n.of(context).rollDice,
          style: const TextStyle(fontSize: 20),
        ),
      );

  Column _directionSelectButton(BuildContext context) => Column(
        children: <Widget>[
          Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: context.select<PlayRoomNotifier, LifeStepModel>((value) => value.currentPlayerLifeStep).hasUp
                  ? () => context.read<PlayerActionNotifier>().direction = Direction.up
                  : null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed:
                    context.select<PlayRoomNotifier, LifeStepModel>((value) => value.currentPlayerLifeStep).hasLeft
                        ? () => context.read<PlayerActionNotifier>().direction = Direction.left
                        : null,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed:
                    context.select<PlayRoomNotifier, LifeStepModel>((value) => value.currentPlayerLifeStep).hasRight
                        ? () => context.read<PlayerActionNotifier>().direction = Direction.right
                        : null,
              ),
            ],
          ),
          Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: context.select<PlayRoomNotifier, LifeStepModel>((value) => value.currentPlayerLifeStep).hasDown
                  ? () => context.read<PlayerActionNotifier>().direction = Direction.down
                  : null,
            ),
          ),
        ],
      );
}
