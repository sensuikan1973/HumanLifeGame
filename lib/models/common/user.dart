import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  UserModel({
    @required this.id,
    @required this.name,
    @required this.isAnonymous,
    this.isEmailVerified = false,
    this.email = '',
    DateTime createdAt,
    DateTime updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;
  final String name;
  final bool isAnonymous;
  final String email;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is UserModel && other.id == id;
}
