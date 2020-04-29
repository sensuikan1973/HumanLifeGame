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

enum LifeItemType {
  job, // 職業
  stock, // 株
  spouse, // 配偶者
  house, // 家
  money, // 金
  childGirl, // 子供(女の子)
  childBoy, // 子供(男の子)
  fireInsurance, // 火災保険
  lifeInsurance, // 生命保険
  coffee, // 消費することで1回休みになる。
}
