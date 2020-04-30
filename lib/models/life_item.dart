/// {@tool sample}
/// for exmaple, Doctor job:
///
/// ```dart
/// LifeItem {
///   key: 'job',
///   type: LifeItemType.job,
///   amount: 1,
/// }
/// ```
/// {@end-tool}
class LifeItem {
  LifeItem(this.key, this.type);

  final String key;
  final LifeItemType type;
  int amount;

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) => other is LifeItem && other.key == key;
}

// 効果を持つアイテムを定義したい場合、都度追加する。
enum LifeItemType {
  job, // 職業
  stock, // 株
  spouse, // 配偶者
  house, // 家
  money, // 金
  vehicle, // 乗り物
  childGirl, // 子供(女の子)
  childBoy, // 子供(男の子)
  fireInsurance, // 火災保険
  lifeInsurance, // 生命保険
  earthquakeInsurance, // 地震保険
  carInsurance, // 自動車保険
  coffee, // 消費することで1回休みになる。持っていたら必ず消費させる。
}
