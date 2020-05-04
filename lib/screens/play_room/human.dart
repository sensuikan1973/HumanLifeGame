import 'package:flutter/material.dart';

class Human extends StatelessWidget {
  const Human();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 15,
        height: 15,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
