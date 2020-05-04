import 'package:flutter/material.dart';

class Human extends StatelessWidget {
  const Human(this.alignment, this.playerColor);
  final Alignment alignment;
  final Color playerColor;
  @override
  Widget build(BuildContext context) => Align(
        alignment: alignment,
        child: SizedBox(
          width: 15,
          height: 15,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: playerColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
}
