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
  child, // 子供
  insurance, // 保険
  coffee, // 消費することで1回休みになる。
  curse, // 呪い。所有してると特定のタイミングで罰をくらうモノ。仕様は要検討。
  blessing, // 祝福。所有してると特定のタイミングで恩恵を得るモノ。仕様は要検討。
}
