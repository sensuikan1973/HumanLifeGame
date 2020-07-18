import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/firestore/life_stage.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';
import '../../i18n/i18n.dart';

/// 人生の進捗結果を発表するダイアログ
class ResultDialog extends StatelessWidget {
  const ResultDialog(this._lifeStages, {Key key}) : super(key: key);

  final List<LifeStageEntity> _lifeStages;

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: Text(I18n.of(context).resultAnnouncementDialogMessage),
        children: [
          for (final lifeStage in _lifeStages)
            Row(
              children: [
                FutureBuilder<Doc<UserEntity>>(
                  future: lifeStage.fetchHuman(context.watch<Store>()),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const SizedBox();
                    return Text(snapshot.data.entity.displayName);
                  },
                ),
                const Text(', 💵: '), // FIXME: 仮テキスト
                Text(lifeStage.totalMoney.toString()),
              ],
            ),
        ],
      );
}
