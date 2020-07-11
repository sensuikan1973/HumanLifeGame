/// event の対象者
enum LifeEventTarget {
  /// LifeEvent を引き起こした張本人の Human のみ
  myself,

  /// 全ての Human
  all,

  // 特定の他の human を対象に取る LifeEvent は当分サポートしない
}
