import 'package:flutter/material.dart';

import '../../i18n/i18n.dart';

class LifeEventRecords extends StatelessWidget {
  const LifeEventRecords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Text(
          I18n.of(context).lifeEventRecordsText,
          key: const Key('lifeEventRecordsText'),
        ),
      );
}
