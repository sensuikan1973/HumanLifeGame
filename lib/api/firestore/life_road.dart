import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/life_event.dart';
import '../../entities/life_event_params/exchange_life_items_params.dart';
import '../../entities/life_event_params/gain_life_items_params.dart';
import '../../entities/life_event_params/goal_params.dart';
import '../../entities/life_event_params/life_event_params.dart';
import '../../entities/life_event_params/lose_life_items_params.dart';
import '../../entities/life_event_params/nothing_params.dart';
import '../../entities/life_event_params/select_direction_params.dart';
import '../../entities/life_event_params/start_params.dart';
import '../../entities/life_event_params/target_life_item_params.dart';
import '../../entities/life_event_target.dart';
import '../../entities/life_event_type.dart';
import '../../entities/life_item_type.dart';
import '../../entities/life_step_entity.dart';
import '../../entities/position.dart';
import 'life_stage.dart';
import 'store.dart';
import 'store_entity.dart';

part 'life_road.freezed.dart';
part 'life_road.g.dart';

@immutable
@freezed
abstract class LifeRoadEntity implements _$LifeRoadEntity, StoreEntity {
  factory LifeRoadEntity({
    @required @DocumentReferenceConverter() DocumentReference author,
    @required @_LifeEventsConverter() List<List<LifeEventEntity>> lifeEvents,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    @Default('') String title,
  }) = _LifeRoadEntity;
  LifeRoadEntity._() : assert(lifeEvents.every((row) => row.length == lifeEvents.first.length)) {
    _initDirections(start);
  }

  factory LifeRoadEntity.fromJson(Map<String, dynamic> json) => _$LifeRoadEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Doc<LifeRoadEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<LifeRoadEntity>(
        store,
        snapshot.reference,
        LifeRoadEntity.fromJson(snapshot.data),
      );

  /// LifeEvent の二次元配列から LifeStep の二次元配列を作るヘルパー
  @visibleForTesting
  static List<List<LifeStepEntity>> createLifeStepsOnBoard(List<List<LifeEventEntity>> lifeEvents) => List.generate(
        lifeEvents.length,
        (y) => List.generate(
          lifeEvents[y].length,
          (x) => LifeStepEntity(
            id: (x + (y * lifeEvents[y].length)).toString(),
            lifeEvent: lifeEvents[y][x],
          ),
        ),
      );

  /// FIXME: いつか消す
  static List<List<LifeEventEntity>> dummyLifeEvents() {
    const start = LifeEventEntity<StartParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.start,
      params: StartParams(),
      description: 'Start だよ',
    );
    const goals = LifeEventEntity<GoalParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.goal,
      params: GoalParams(),
      description: 'Goal だよ',
    );
    const gains = LifeEventEntity<GainLifeItemsParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.gainLifeItems,
      params: GainLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
      ]),
      description: 'お金ゲット〜',
    );
    const loses = LifeEventEntity<LoseLifeItemsParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.loseLifeItems,
      params: LoseLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
      ]),
      description: 'お金なくした...',
    );
    const exchg = LifeEventEntity<ExchangeLifeItemsParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.exchangeLifeItems,
      params: ExchangeLifeItemsParams(
        targetItems: [
          TargetLifeItemParams(key: 'HumanLifeGames Inc.', type: LifeItemType.stock, amount: 1),
        ],
        baseItems: [
          TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
        ],
      ),
      description: '株を購入する',
    );
    const direc = LifeEventEntity<SelectDirectionParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.selectDirection,
      params: SelectDirectionParams(),
      description: '分岐だよー',
    );
    const blank = LifeEventEntity<NothingParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.nothing,
      params: NothingParams(),
    );
    return [
      [start, direc, gains, gains, exchg, loses, blank, blank, blank, blank],
      [blank, gains, blank, blank, blank, gains, blank, blank, blank, blank],
      [blank, gains, gains, loses, gains, gains, gains, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, exchg, blank, blank, blank],
      [goals, exchg, loses, gains, exchg, loses, direc, blank, blank, blank],
      [blank, gains, blank, blank, blank, blank, gains, blank, blank, blank],
      [blank, gains, exchg, loses, gains, gains, gains, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
    ];
  }

  /// lifeEvents を二次元配列として展開かつ LifeStepEntity として解釈済みのもの
  @late
  List<List<LifeStepEntity>> get lifeStepsOnBoard => LifeRoadEntity.createLifeStepsOnBoard(lifeEvents);

  /// Y 方向の長さ
  @late
  int get height => lifeEvents.length;

  /// X 方向の長さ
  @late
  int get width => lifeEvents.first.length;

  /// Start
  @late
  LifeStepEntity get start => lifeStepsOnBoard
      .expand((el) => el)
      .firstWhere((step) => step.isStart, orElse: () => throw Exception('LifeRoad should have Start'));

  /// LifeStep の座標を取得する
  Position getPosition(LifeStepEntity lifeStep) {
    for (var y = 0; y < lifeStepsOnBoard.length; ++y) {
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        if (lifeStepsOnBoard[y][x] == lifeStep) return Position(y, x);
      }
    }
    throw Exception('lifeStep should be in lifeStepsOnBoard');
  }

  /// id を元に取得
  @late
  LifeStepEntity getStepEntity(LifeStageEntity lifeStage) =>
      lifeStepsOnBoard.expand((el) => el).firstWhere((el) => el.id == lifeStage.currentLifeStepId);

  // LifeSte の上下左右を再帰的にチェックし、連結リスト構造を構築する
  void _initDirections(LifeStepEntity currentLifeStep) {
    if (currentLifeStep.isGoal) return;

    bool _isUncheckedLifeStep(LifeStepEntity lifeStep) {
      if (!lifeStep.isTargetToRoad) return false;
      return [lifeStep.up, lifeStep.down, lifeStep.right, lifeStep.left].every((el) => el == null);
    }

    final pos = getPosition(currentLifeStep);
    LifeStepEntity upLifeStep;
    LifeStepEntity downLifeStep;
    LifeStepEntity rightLifeStep;
    LifeStepEntity leftLifeStep;
    var isUpUnchecked = false;
    var isDownUnchecked = false;
    var isRightUnchecked = false;
    var isLeftUnchecked = false;
    var numOfUncheckedLifeStep = 0;

    // 現在のLifeStepの上下左右に未探索のLifeStepが存在するか
    // 上方をチェック
    if (pos.y != 0) {
      upLifeStep = lifeStepsOnBoard[pos.y - 1][pos.x];
      if (isUpUnchecked = _isUncheckedLifeStep(upLifeStep)) numOfUncheckedLifeStep++;
    }
    // 下方をチェック
    if (pos.y != height - 1) {
      downLifeStep = lifeStepsOnBoard[pos.y + 1][pos.x];
      if (isDownUnchecked = _isUncheckedLifeStep(downLifeStep)) numOfUncheckedLifeStep++;
    }
    // 右方をチェック
    if (pos.x != width - 1) {
      rightLifeStep = lifeStepsOnBoard[pos.y][pos.x + 1];
      if (isRightUnchecked = _isUncheckedLifeStep(rightLifeStep)) numOfUncheckedLifeStep++;
    }
    // 左方をチェック
    if (pos.x != 0) {
      leftLifeStep = lifeStepsOnBoard[pos.y][pos.x - 1];
      if (isLeftUnchecked = _isUncheckedLifeStep(leftLifeStep)) numOfUncheckedLifeStep++;
    }

    // 分岐するEventの場合のフロー
    if (currentLifeStep.isBranch) {
      if (numOfUncheckedLifeStep > 1) {
        if (isUpUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].up = upLifeStep;
          _initDirections(upLifeStep);
        }
        if (isDownUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].down = downLifeStep;
          _initDirections(downLifeStep);
        }
        if (isRightUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].right = rightLifeStep;
          _initDirections(rightLifeStep);
        }
        if (isLeftUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].left = leftLifeStep;
          _initDirections(leftLifeStep);
        }
      }
      // TODO: エラー（もしくは離小島にジャンプ）
    } else {
      if (numOfUncheckedLifeStep == 1) {
        // 次のLifeStepと紐付けし、次のLifeStepから探索を開始
        if (isUpUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].up = upLifeStep;
          _initDirections(upLifeStep);
        } else if (isDownUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].down = downLifeStep;
          _initDirections(downLifeStep);
        } else if (isRightUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].right = rightLifeStep;
          _initDirections(rightLifeStep);
        } else if (isLeftUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].left = leftLifeStep;
          _initDirections(leftLifeStep);
        }
        // TODO: 例外
      } else if (numOfUncheckedLifeStep > 1) {
        // 合流のため、探索終了
        // TODO: LifeStepが４つボックス状にくっついてたらどうする
      }
      // TODO: 例外（もしくは離小島にジャンプ）
    }
  }

  /// lifeEvents を人間が読める文字列として出力する
  @visibleForTesting
  String dump() {
    final messageBuffer = StringBuffer();
    for (var y = 0; y < lifeStepsOnBoard.length; ++y) {
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        messageBuffer.write('type:${lifeStepsOnBoard[y][x].lifeEvent.type.index}   ');
      }
      messageBuffer.writeln();

      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        lifeStepsOnBoard[y][x].up != null ? messageBuffer.write('up:exist ') : messageBuffer.write('up:null  ');
      }
      messageBuffer.writeln();

      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        lifeStepsOnBoard[y][x].down != null ? messageBuffer.write('dn:exist ') : messageBuffer.write('dn:null  ');
      }
      messageBuffer.writeln();

      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        lifeStepsOnBoard[y][x].right != null ? messageBuffer.write('rl:exist ') : messageBuffer.write('rl:null  ');
      }
      messageBuffer.writeln();

      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        lifeStepsOnBoard[y][x].left != null ? messageBuffer.write('lt:exist ') : messageBuffer.write('lt:null  ');
      }
      messageBuffer.writeln();
    }
    return messageBuffer.toString();
  }
}

class LifeRoadEntityField {
  /// 作成者
  static const author = 'author';

  /// タイトル
  static const title = 'title';

  /// LifeRoad の LifeEvent 配列
  ///
  /// クライアントサイドで二次元に展開 + 連結リスト化 するのが必要
  static const lifeEvents = 'lifeEvents';
}

/// NOTE: 2020/07/11 時点で、Firestore は "直接ネストされた配列" をサポートしてない
/// lifeEvents は実際には二次元配列として扱いたいところだが、その制約があるため、Firestore 上では異なる形式(map)で保存する
/// ```dart
/// {
///   height: 100,
///   width: 100,
///   events: [], // 一次元配列
/// }
/// ```
@immutable
class _LifeEventsConverter implements JsonConverter<List<List<LifeEventEntity>>, Map<String, dynamic>> {
  const _LifeEventsConverter();

  @override
  List<List<LifeEventEntity>> fromJson(Map<String, dynamic> json) {
    final height = json[_LifeEventsField.height.name] as int;
    final width = json[_LifeEventsField.width.name] as int;
    final events = json[_LifeEventsField.events.name] as List;
    final result = <List<LifeEventEntity>>[];
    for (var h = 0; h < height; ++h) {
      final row = <LifeEventEntity>[];
      for (var w = 0; w < width; ++w) {
        row.add(
          LifeEventEntity.fromJson(events[h * width + w] as Map<String, dynamic>),
        );
      }
      result.add(row);
    }
    return result;
  }

  @override
  Map<String, dynamic> toJson(List<List<LifeEventEntity>> entities) => <String, dynamic>{
        _LifeEventsField.height.name: entities.length,
        _LifeEventsField.width.name: entities.first.length,
        _LifeEventsField.events.name: entities.expand((el) => el).map((entity) => entity.toJson()).toList(),
      };
}

// NOTE: これは Firestore の世界とクライアント解釈を繋ぐための存在に過ぎないので、private でいい
enum _LifeEventsField {
  /// Y 方向の長さ
  height,

  /// X 方向の長さ
  width,

  /// LifeEvent が一次元に展開された配列
  events,
}

extension _LifeEventsFieldExtension on _LifeEventsField {
  String get name => describeEnum(this);
}
