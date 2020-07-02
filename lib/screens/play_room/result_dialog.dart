import 'package:flutter/material.dart';

import '../../i18n/i18n.dart';
import '../../models/play_room/life_stage.dart';

/// 人生の進捗結果を発表するダイアログ
class ResultDialog extends StatelessWidget {
  const ResultDialog(this._lifeStages, {Key key}) : super(key: key);

  final List<LifeStageModel> _lifeStages;

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: Text(I18n.of(context).resultAnnouncementDialogMessage),
        children: [
          for (final lifeStage in _lifeStages)
            Row(
              children: [
                Text(lifeStage.human.entity.displayName),
                const Text(', 💵: '), // FIXME: 仮テキスト
                Text(lifeStage.totalMoney.toString()),
              ],
            ),
        ],
      );
}
