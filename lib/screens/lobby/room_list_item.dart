import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../router.dart';

class RoomListItem extends StatelessWidget {
  const RoomListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        child: Column(
          children: [
            _roomTitle(),
            Row(
              children: [
                _preview(),
                Column(
                  children: [
                    _humans(),
                    _joinButton(context),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  SizedBox _roomTitle() => SizedBox(
        width: 720,
        height: 40,
        child: ColoredBox(
          color: Colors.grey[100],
          child: const Text('Room 1'),
        ),
      );

  SizedBox _preview() => SizedBox(
        width: 300,
        height: 200,
        child: Image.asset(
          'images/play_view_background.jpg',
          fit: BoxFit.fitHeight,
        ),
      );

  SizedBox _humans() => SizedBox(
        width: 420,
        height: 170,
        child: Column(
          children: const [
            Text('Human 1'),
            Text('Human 2'),
          ],
        ),
      );

  SizedBox _joinButton(BuildContext context) => SizedBox(
        width: 420,
        height: 40,
        child: FlatButton(
          color: Colors.lightBlue,
          onPressed: () => Navigator.of(context).pushNamed(context.read<Router>().playRoom),
          child: const Text('Join a Game'),
        ),
      );
}
