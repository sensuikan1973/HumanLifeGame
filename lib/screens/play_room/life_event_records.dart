import 'package:flutter/material.dart';

import '../../i18n/i18n.dart';

class LifeEventRecords extends StatelessWidget {
  const LifeEventRecords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: ListView(
          reverse: true,
          children: [
            // FIXME : 仮のテキストを表示
            for (var i = 0; i < 10; ++i)
              Text(
                '$I18n.of(context).lifeEventRecordsText : $i',
              ),
          ],
        ),
      );
}
