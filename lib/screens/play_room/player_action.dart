import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../i18n/i18n.dart';
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
        onPressed: () => context.read<PlayerActionModel>().rollDice(),
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
                  key: const Key('playerActionDilectionSelectUpButton'),
                  icon: Icon(Icons.arrow_upward),
                  onPressed: null),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                key: const Key('playerActionDilectionSelectLeftButton'),
                icon: Icon(Icons.arrow_back),
                onPressed: null,
              ),
              IconButton(
                key: const Key('playerActionDilectionSelectRightButton'),
                icon: Icon(Icons.arrow_forward),
                onPressed: null,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                key: const Key('playerActionDilectionSelectDownButton'),
                icon: Icon(Icons.arrow_downward),
                onPressed: null,
              ),
            ],
          ),
        ],
      );
  Row _yesNoButton(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            key: const Key('playerActiontwoChoiceNoButton'),
            icon: Icon(Icons.close),
            onPressed: null,
          ),
          IconButton(
            key: const Key('playerActiontwoChoiceYesButton'),
            icon: Icon(Icons.radio_button_unchecked),
            onPressed: null,
          ),
        ],
      );
}
