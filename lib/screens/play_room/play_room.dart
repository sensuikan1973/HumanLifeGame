import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/dice.dart';
import '../../api/firestore/play_room.dart';
import '../../api/firestore/store.dart';
import '../../i18n/i18n.dart';
import '../../models/play_room/play_room_notifier.dart';
import 'announcement.dart';
import 'dice_result.dart';
import 'life_event_records.dart';
import 'life_stages.dart';
import 'play_view.dart';
import 'player_action.dart';
import 'result_dialog.dart';

@immutable
class PlayRoomNavigateArguments {
  const PlayRoomNavigateArguments(this.playRoomDoc);
  final Doc<PlayRoomEntity> playRoomDoc;
}

class PlayRoom extends StatefulWidget {
  const PlayRoom._();

  static Widget inProviders({@required Doc<PlayRoomEntity> playRoomDoc, Key key}) => Builder(
        builder: (context) => MultiProvider(
          key: key,
          providers: [
            ChangeNotifierProvider<PlayRoomNotifier>(
              create: (_) => PlayRoomNotifier(
                I18n.of(context),
                context.read<Dice>(),
                context.read<Store>(),
                playRoomDoc,
              ),
            ),
          ],
          child: const PlayRoom._(),
        ),
      );

  @override
  PlayRoomState createState() => PlayRoomState();
}

class PlayRoomState extends State<PlayRoom> {
  bool isDisplayedResult = false;
  final hasInitialized = ValueNotifier<bool>(false);

  Size get _desktopSize => const Size(1440, 1024); // FIXME: 最終的には、左側のビューと右側のビューの最小サイズをトリガとして切り替える
  Size get _announcementSize => const Size(1050, 50);
  Size get _lifeEventRecordsSize => const Size(1050, 50);
  Size get _lifeStagesSize => const Size(200, 500);
  Size get _diceResultSize => const Size(200, 100);
  Size get _playerActionSize => const Size(200, 300);
  bool get _showLifeEventRecords =>
      MediaQuery.of(context).size.height >
      _announcementSize.height + _lifeEventRecordsSize.height + _playViewSize.height;
  Size get _playViewSize {
    const defaultPlayViewSize = Size(1050, 750);
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width > defaultPlayViewSize.width ? defaultPlayViewSize.width : screenSize.width;
    final height = screenSize.height < defaultPlayViewSize.height + _announcementSize.height
        ? screenSize.height - _announcementSize.height
        : defaultPlayViewSize.height;
    return Size(width, height);
  }

  @visibleForTesting
  static const showDelay = Duration(milliseconds: 200);

  void _showDialogCallback() {
    if (isDisplayedResult) return;
    if (context.select<PlayRoomNotifier, bool>((notifier) => notifier.value.allHumansReachedTheGoal)) {
      isDisplayedResult = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async => showDialog<void>(
            context: context,
            builder: (_) => ResultDialog(context.read<PlayRoomNotifier>().value.lifeStages),
          ));
    }
  }

  @override
  void initState() {
    context.read<PlayRoomNotifier>().init().then((_) async {
      await Future<void>.delayed(showDelay);
      return hasInitialized.value = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _showDialogCallback();
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: hasInitialized,
        builder: (_, hasInitialized, __) {
          if (!hasInitialized) return const CupertinoActivityIndicator();
          return MediaQuery.of(context).size.width >= _desktopSize.width ? _largeScreen() : _middleScreen();
        },
      ),
    );
  }

  Row _largeScreen() => Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                width: _announcementSize.width,
                height: _announcementSize.height,
                child: const Announcement(),
              ),
              if (_showLifeEventRecords)
                Expanded(
                  child: SizedBox(
                    width: _lifeEventRecordsSize.width,
                    child: const LifeEventRecords(),
                  ),
                ),
              SizedBox(
                width: _playViewSize.width,
                height: _playViewSize.height,
                child: const PlayView(),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: const <Widget>[
                  Expanded(flex: 2, child: LifeStages()),
                  Expanded(child: DiceResult()),
                  Expanded(child: PlayerAction()),
                ],
              ),
            ),
          ),
        ],
      );

  Column _middleScreen() => Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width < _announcementSize.width
                ? MediaQuery.of(context).size.width
                : _announcementSize.width,
            height: _announcementSize.height,
            child: const Announcement(),
          ),
          if (_showLifeEventRecords)
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width < _lifeEventRecordsSize.width
                    ? MediaQuery.of(context).size.width
                    : _lifeEventRecordsSize.width,
                child: const LifeEventRecords(),
              ),
            ),
          Stack(
            children: <Widget>[
              SizedBox(
                width: _playViewSize.width,
                height: _playViewSize.height,
                child: const PlayView(),
              ),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: _playViewSize.height,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: _lifeStagesSize.width,
                          child: const LifeStages(),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: _diceResultSize.width,
                          child: const DiceResult(),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: _playerActionSize.width,
                          child: const PlayerAction(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isDisplayedResult', isDisplayedResult))
      ..add(DiagnosticsProperty<ValueNotifier<bool>>('hasInitialized', hasInitialized));
  }
}
