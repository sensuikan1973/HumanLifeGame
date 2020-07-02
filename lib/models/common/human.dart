import 'package:flutter/foundation.dart';

@immutable
class HumanModel {
  const HumanModel({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is HumanModel && other.id == id;
}
