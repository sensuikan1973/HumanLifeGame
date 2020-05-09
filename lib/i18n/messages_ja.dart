// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  static m0(type) => "${Intl.select(type, {
        'nothing': '',
        'start': 'スタート',
        'goal': 'ゴール',
        'selectDirection': '方向を選択',
        'gainLifeItems': 'アイテムを獲得 :',
        'loseLifeItems': 'アイテムを損失 :',
      })}";

  static m1(name, roll) => "${name} がサイコロを振りました. 結果: ${roll}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("人生すごろく"),
        "lifeEventRecordsText": MessageLookupByLibrary.simpleMessage("予約領域:lifeEventRecords"),
        "lifeStepEventType": m0,
        "playerActionNo": MessageLookupByLibrary.simpleMessage("いいえ"),
        "playerActionYes": MessageLookupByLibrary.simpleMessage("はい"),
        "rollAnnouncement": m1,
        "rollDice": MessageLookupByLibrary.simpleMessage("サイコロを振る")
      };
}
