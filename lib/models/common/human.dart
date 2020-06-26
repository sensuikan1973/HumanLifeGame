import 'package:flutter/foundation.dart';

@immutable
class HumanModel {
  const HumanModel({
    @required this.id,
    @required this.name,
    @required this.order,
  });

  final String id;
  final String name;
  final int order;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is HumanModel && other.id == id;
}
