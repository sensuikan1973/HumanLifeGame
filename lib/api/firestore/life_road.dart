import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/life_step_entity.dart';
import '../../models/common/life_event_params/life_event_params.dart';
import 'entity.dart';
import 'life_event.dart';
import 'store.dart';

part 'life_road.freezed.dart';
part 'life_road.g.dart';

@freezed
abstract class LifeRoadEntity implements _$LifeRoadEntity, Entity {
  factory LifeRoadEntity({
    @required @DocumentReferenceConverter() DocumentReference author,
    @required List<LifeEventEntity> lifeEvents,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
    @Default('') String title,
  }) = _LifeRoadEntity;
  LifeRoadEntity._();

  factory LifeRoadEntity.fromJson(Map<String, dynamic> json) => _$LifeRoadEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Doc<LifeRoadEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<LifeRoadEntity>(
        store,
        snapshot.reference,
        LifeRoadEntity.fromJson(snapshot.data),
      );

  /// lifeEvents を二次元配列として展開かつ LifeStepEntity として解釈済みのもの
  @late
  List<List<LifeStepEntity>> get lifeStepsOnBoard => _lifeStepsOnBoard;
  List<List<LifeStepEntity>> get _lifeStepsOnBoard {
    return [];
  }

  /// Y 方向の長さ
  @late
  int get height => lifeStepsOnBoard.length;

  /// X 方向の長さ
  @late
  int get width => lifeStepsOnBoard.first.length;

  /// Start
  @late
  LifeStepEntity get start => _start;
  LifeStepEntity get _start {
    final startSteps = lifeStepsOnBoard.expand((el) => el).where((step) => step.isStart);
    if (startSteps.isEmpty || startSteps.length > 1) {
      throw Exception('start step should be just one. found start ${startSteps.length} steps.');
    }
    return startSteps.first;
  }

  /// LifeStep の座標を取得する
  Position getPosition(LifeStepEntity lifeStep) {
    for (var y = 0; y < lifeStepsOnBoard.length; ++y) {
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        if (lifeStepsOnBoard[y][x] == lifeStep) return Position(y, x);
      }
    }
    throw Exception('lifeStep should be in lifeStepsOnBoard');
  }

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
      } else {
        // TODO: エラー（もしくは離小島にジャンプ）
      }
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
        } else {
          // TODO: 例外
        }
      } else if (numOfUncheckedLifeStep > 1) {
        // 合流のため、探索終了
        // TODO: LifeStepが４つボックス状にくっついてたらどうする
        return;
      } else {
        // TODO: 例外（もしくは離小島にジャンプ）
      }
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

@immutable
class Position {
  const Position(this.y, this.x);
  final int y;
  final int x;
}
