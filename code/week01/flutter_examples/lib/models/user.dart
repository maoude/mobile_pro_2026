// =====================================================================
// Shared data model: User (from lecture 1.1, section 2.2)
// =====================================================================
// This is the same immutable model as lect_01_01/03_user_model.dart (read
// that file for the full explanation). It is used by the Flutter examples
// 04, 05 and 07.
//
// This file has no main(); it is imported by the examples.
// =====================================================================

class User {
  // "final" fields: the object never changes after it is created.
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now() {
    // Refuse to create an invalid object.
    if (!email.contains('@')) {
      throw ArgumentError('Invalid email format');
    }
  }

  // JSON (a Map) -> User
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  // User -> JSON (a Map)
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'created_at': createdAt.toIso8601String(),
      };
}
