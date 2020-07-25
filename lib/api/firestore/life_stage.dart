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
    @required @_UnmodifiableSetViewConverter() UnmodifiableSetView<LifeItemEntity> items,
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
  int get possession => items.isEmpty ? 0 : items.firstWhere((item) => item.type == LifeItemType.money).amount;
}

class LifeStageEntityField {
  /// 対象の human
  static const human = 'human';

  /// 現在位置する LifeStep の識別子
  static const currentLifeStepId = 'currentLifeStepId';
}

@immutable
class _UnmodifiableSetViewConverter
    implements JsonConverter<UnmodifiableSetView<LifeItemEntity>, List<Map<String, dynamic>>> {
  const _UnmodifiableSetViewConverter();

  @override
  UnmodifiableSetView<LifeItemEntity> fromJson(List<Map<String, dynamic>> json) {
    final jsonSet = json.map((map) => LifeItemEntity.fromJson(map)).toSet();
    return UnmodifiableSetView<LifeItemEntity>(jsonSet);
  }

  @override
  List<Map<String, dynamic>> toJson(UnmodifiableSetView<LifeItemEntity> setView) =>
      setView.toList().map((entity) => entity.toJson()).toList();
}
