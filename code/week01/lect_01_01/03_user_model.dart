// Source: 002_lect_01_01.tex, section 2.2 OOP in Dart - Class Definition and Constructors
// Pure Dart (add a main() to create a User). Used by later examples.

import 'dart:convert';

class User {
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
    if (!email.contains('@')) {
      throw ArgumentError('Invalid email format');
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'created_at': createdAt.toIso8601String(),
  };
}

// Note: factory may return cached instances or subtypes; not required to allocate.
