import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:flutter/material.dart';

class LifeEventRecordes extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400,
        height: 100,
        child: Text(
          I18n.of(context).lifeEventRecordesText,
          key: const Key('lifeEventRecordsText'),
        ),
      );
}
