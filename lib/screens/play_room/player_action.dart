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
          child: Column(
            children: <Widget>[
              _directionSelectButton(context),
              const Divider(
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              _yesNoButton(context),
              const Divider(
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              _rollDiceButton(context),
            ],
          ),
        ),
      );

  FlatButton _rollDiceButton(BuildContext context) => FlatButton(
        key: const Key('playerActionDiceRollButton'),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: context.select<PlayRoomModel, bool>((model) => model.allHumansReachedTheGoal)
            ? null
            : () => context.read<PlayerActionModel>().rollDice(),
        child: Text(
          I18n.of(context).rollDice,
          style: const TextStyle(fontSize: 20),
        ),
      );

  Column _directionSelectButton(BuildContext context) => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: () => context.read<PlayerActionModel>().direction = Direction.up,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.read<PlayerActionModel>().direction = Direction.left,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => context.read<PlayerActionModel>().direction = Direction.right,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_downward),
                onPressed: () => context.read<PlayerActionModel>().direction = Direction.down,
              ),
            ],
          ),
        ],
      );
  Row _yesNoButton(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            onPressed: null,
            child: Text(
              I18n.of(context).playerActionYes,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          FlatButton(
            onPressed: null,
            child: Text(
              I18n.of(context).playerActionNo,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      );
}
