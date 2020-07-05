import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/firestore/service_control.dart';
import '../../api/firestore/store.dart';

/// FIXME: ロジックべた書き
class Maintenance extends StatelessWidget {
  const Maintenance({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: StreamBuilder<Doc<ServiceControlEntity>>(
            stream: context.watch<Store>().docRef<ServiceControlEntity>(ServiceControlDocId.web).document(),
            builder: (context, snap) {
              if (!snap.hasData) return const Text('no data');
              return snap.data.entity.isMaintenance
                  ? const Text('under maintenance')
                  : const Text('not under maintenance');
            },
          ),
        ),
      );
}
