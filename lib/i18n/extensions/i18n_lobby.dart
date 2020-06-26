import 'package:intl/intl.dart';

import '../i18n.dart';

/// Lobby Locale Text
extension I18nLobby on I18n {
  String get lobbyCreatePublicRoomButtonTooltip => Intl.message(
        'create public room',
        name: 'lobbyCreatePublicRoomButtonTooltip',
        locale: localeName,
      );
  String get lobbyEnterTheRoomButtonText => Intl.message(
        'enter the room',
        name: 'lobbyEnterTheRoomButtonText',
        locale: localeName,
      );
}
