import 'package:flutter/material.dart';

/// Humanの状況を表示
class HumanLifeStages extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 100,
        height: 100,
        child: _userId(context),
      );

  Column _userId(BuildContext context) {
    final userId = <Widget>[
      const Text('human 1'),
      const Text('human 2'),
      const Text('human 3'),
      const Text('human 4'),
    ];
    return Column(
      children: userId,
    );
  }
}
