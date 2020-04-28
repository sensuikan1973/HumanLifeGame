import 'package:flutter/material.dart';

// ヒューマンの情報を表示
class HumanInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = <Widget>[
      const Text('human 1'),
      const Text('human 2'),
      const Text('human 3'),
      const Text('human 4'),
    ];

    return Container(
        width: 100,
        height: 100,
        child: Column(
          children: userId,
        ));
  }
}
