import 'package:flutter/material.dart';

class LobbyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LobbyAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        title: const Text(
          'Human Life Game', // TODO: i18n
          style: TextStyle(
            fontFamily: 'varela',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // See: https://docs.flutter.io/flutter/material/AppBar/preferredSize.html
}
