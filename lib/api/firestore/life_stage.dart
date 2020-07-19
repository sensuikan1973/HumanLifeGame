import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/life_item.dart';
import '../../entities/life_item_type.dart';
import 'store.dart';
import 'store_entity.dart';
import 'user.dart';

part 'life_stage.freezed.dart';
part 'life_stage.g.dart';

@immutable
@freezed
abstract class LifeStageEntity implements _$LifeStageEntity, StoreEntity {
  const factory LifeStageEntity({
    @required @DocumentReferenceConverter() DocumentReference human,
    @required @_LifeItemsConverter() List<LifeItemEntity> items,
    @required String currentLifeStepId,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _LifeStageEntity;
  const LifeStageEntity._();

  factory LifeStageEntity.fromJson(Map<String, dynamic> json) => _$LifeStageEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Doc<LifeStageEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<LifeStageEntity>(
        store,
        snapshot.reference,
        LifeStageEntity.fromJson(snapshot.data),
      );

  /// この人生の進捗を歩んでる human を取得する
  @late
  Future<Doc<UserEntity>> fetchHuman(Store store) async => UserEntity.decode(store, await human.get());

  /// 所持金
  int get totalMoney => items.isEmpty
      ? 0
      : items
          .where((item) => item.type == LifeItemType.money)
          .map((money) => money.amount)
          .reduce((val, el) => val + el);
}

class LifeStageEntityField {
  /// 対象の human
  static const human = 'human';

  /// 現在位置する LifeStep の識別子
  static const currentLifeStepId = 'currentLifeStepId';
}

/// 以下の形式で Firestore 上に保存する
/// ```dart
/// {
///   'money_yen': {
///     key: 'money_yen',
///     type: 'money',
///     amount: 1000,
///   }
/// }
/// ```
class _LifeItemsConverter implements JsonConverter<List<LifeItemEntity>, Map<String, dynamic>> {
  const _LifeItemsConverter();

  @override
  List<LifeItemEntity> fromJson(Map<String, dynamic> json) {
    final entities = <LifeItemEntity>[];
    for (final entry in json.entries) {
      entities.add(LifeItemEntity.fromJson(entry.value as Map<String, dynamic>));
    }
    return entities;
  }

  @override
  Map<String, dynamic> toJson(List<LifeItemEntity> entities) {
    final map = <String, dynamic>{};
    for (final entity in entities) {
      map[entity.key] = entity.toJson();
    }
    return map;
  }
}
