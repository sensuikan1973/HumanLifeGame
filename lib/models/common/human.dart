import 'package:flutter/foundation.dart';

import 'user.dart';

class HumanModel {
  HumanModel({@required this.id, @required this.name, @required this.order});
  HumanModel.fromUserModel(UserModel user, this.order)
      : id = user.id,
        name = user.name;

  final String id;
  final String name;
  final int order;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is HumanModel && other.id == id;
}
