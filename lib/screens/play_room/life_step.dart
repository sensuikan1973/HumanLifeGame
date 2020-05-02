import 'package:flutter/material.dart';

class LifeStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 100,
          height: 60,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
        ),
      );
}
