import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:flutter/material.dart';

class PlayerAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: 100,
          height: 100,
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {},
            child: Text(
              I18n.of(context).start,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
}
