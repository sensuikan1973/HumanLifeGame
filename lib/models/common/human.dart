import 'package:flutter/material.dart';

import 'user.dart';

class HumanModel {
  HumanModel({@required this.id, @required this.name, this.icon});
  HumanModel.fromUserModel(UserModel user)
      : id = user.id,
        name = user.name,
        icon = Colors.grey[50];

  final String id;
  final String name;
  final Color icon;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is HumanModel && other.id == id;
}
