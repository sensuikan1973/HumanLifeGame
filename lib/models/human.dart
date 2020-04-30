import 'package:HumanLifeGame/models/user.dart';

class Human {
  Human(this.id, this.name);
  Human.fromUser(User user)
      : id = user.id,
        name = user.name;

  final String id;
  final String name;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Human && other.id == id;
}
