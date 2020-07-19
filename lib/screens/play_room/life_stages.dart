import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/firestore/life_stage.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';
import '../../models/play_room/play_room_notifier.dart';
import '../common/human.dart';

/// 各 Human たちの人生の進捗(= LifeStage)を表示
class LifeStages extends StatelessWidget {
  const LifeStages({Key key}) : super(key: key);

  Icon _turnSelector() => const Icon(Icons.chevron_right, color: Colors.pink);

  @override
  Widget build(BuildContext context) => Card(child: _lifeStages(context));

  Column _lifeStages(BuildContext context) {
    final lifeStages = context.select<PlayRoomNotifier, List<LifeStageEntity>>((notifier) => notifier.value.lifeStages);
    final currentTurnHuman =
        context.select<PlayRoomNotifier, Doc<UserEntity>>((notifier) => notifier.value.currentTurnHuman);
    return Column(
      children: [
        for (final lifeStage in lifeStages)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: (currentTurnHuman.id == lifeStage.human.documentID) ? _turnSelector() : null,
              ),
              FutureBuilder<Doc<UserEntity>>(
                future: lifeStage.fetchHuman(context.watch<Store>()),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  return Human(snapshot.data);
                },
              ),
              FutureBuilder<Doc<UserEntity>>(
                future: lifeStage.fetchHuman(context.watch<Store>()),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  return Text(snapshot.data.entity.displayName);
                },
              ),
              const Text(', 💵: '), // FIXME: 仮テキスト
              Text(lifeStage.possession.toString()),
            ],
          ),
      ],
    );
  }
}
