import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/firestore/life_event_record.dart';
import '../../i18n/i18n.dart';
import '../../models/play_room/play_room_notifier.dart';

class LifeEventRecords extends StatelessWidget {
  const LifeEventRecords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final everyLifeEventRecords = context
        .select<PlayRoomNotifier, List<LifeEventRecordEntity>>((notifier) => notifier.value.everyLifeEventRecords);

    return Card(
      child: ListView(
        reverse: true,
        children: [
          for (final record in everyLifeEventRecords)
            Text(
              I18n.of(context).lifeStepEventType(record.lifeEvent.type),
            ),
        ],
      ),
    );
  }
}
