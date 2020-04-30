class User {
  User(this.id, this.name, this.createdAt, this.updatedAt);

  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is User && other.id == id;
}
