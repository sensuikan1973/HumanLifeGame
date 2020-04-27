import 'package:flutter/material.dart';

class HumanAction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HumanActionState();
}

class _HumanActionState extends State<HumanAction> {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: 100,
          height: 100,
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {},
            child: const Text(
              'Start',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
}
