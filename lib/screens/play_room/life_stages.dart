import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/firestore/user.dart';
import '../../models/play_room/life_stage.dart';
import '../../models/play_room/play_room_notifier.dart';
import '../common/human.dart';

/// 各 Human たちの人生の進捗(= LifeStage)を表示
class LifeStages extends StatelessWidget {
  const LifeStages({Key key}) : super(key: key);

  Icon _turnSelector() => const Icon(Icons.chevron_right, color: Colors.pink);

  @override
  Widget build(BuildContext context) => Card(child: _lifeStages(context));

  Column _lifeStages(BuildContext context) {
    final lifeStages = context.select<PlayRoomNotifier, List<LifeStageModel>>((notifier) => notifier.value.lifeStages);
    final currentTurnHuman =
        context.select<PlayRoomNotifier, Document<UserEntity>>((notifier) => notifier.value.currentTurnHuman);
    return Column(
      children: [
        for (final lifeStage in lifeStages)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: (currentTurnHuman == lifeStage.human) ? _turnSelector() : null,
              ),
              Human(lifeStage.human),
              Text(lifeStage.human.entity.displayName),
              const Text(', 💵: '), // FIXME: 仮テキスト
              Text(lifeStage.totalMoney.toString()),
            ],
          ),
      ],
    );
  }
}
