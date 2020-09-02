import 'package:intl/intl.dart';

import '../i18n.dart';

/// Lobby Locale Text
extension I18nLobby on I18n {
  String get makeRoomButtonText => Intl.message(
        'Make a Room',
        name: 'makeRoomButtonText',
        locale: localeName,
      );
  String get joinRoomButtonText => Intl.message(
        'Join a Room',
        name: 'joinRoomButtonText',
        locale: localeName,
      );
}
