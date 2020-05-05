import 'user.dart';

class HumanModel {
  HumanModel(this.id, this.name);
  HumanModel.fromUserModel(UserModel user)
      : id = user.id,
        name = user.name;

  final String id;
  final String name;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is HumanModel && other.id == id;
}
