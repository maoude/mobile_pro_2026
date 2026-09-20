// =====================================================================
// Lecture 1.1, section 2.2: A class with named parameters, validation
// and JSON conversion (an immutable data model)
// =====================================================================
// WHAT YOU LEARN
//   * "final" fields make the object IMMUTABLE: it can never change after
//     it is created. Flutter relies on immutable data for predictable UIs.
//   * Named parameters + "required": the caller must name every value, so
//     calls are readable and mistakes are impossible.
//   * The initializer list (after the ":") sets a default value.
//   * The constructor body validates the data and throws on bad input.
//   * A factory constructor (User.fromJson) builds a User from a Map, and
//     toJson() does the reverse: the pattern used to talk to web services.
//
// HOW TO RUN
//   dart run 03_user_model.dart
//
// EXPECTED OUTPUT
//   Created: Ali <ali@example.com>
//   JSON: {"id":"1","name":"Ali","email":"ali@example.com","created_at":"2026-01-15T10:30:00.000Z"}
//   Round trip works: true
//   createdAt defaults to now: true
//   Rejected: Invalid email format
// =====================================================================

import 'dart:convert'; // jsonEncode / jsonDecode

class User {
  // "final": each field is set once in the constructor and never changes.
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  User({
    required this.id, // required: the caller MUST provide it
    required this.name,
    required this.email,
    DateTime? createdAt, // optional: may be omitted (it is nullable)
  }) : createdAt = createdAt ?? DateTime.now() {
    // ^ initializer list: if no createdAt was given, use the current time.
    // Validation: refuse to create an invalid object.
    if (!email.contains('@')) {
      throw ArgumentError('Invalid email format');
    }
  }

  // A factory constructor may return an object built from other data.
  // Here it turns a JSON-like Map into a User. "as String" tells Dart the
  // type of each value (Map values are "dynamic").
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  // The reverse: turn the User into a Map that jsonEncode can convert.
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'created_at': createdAt.toIso8601String(),
  };
}

void main() {
  // 1) Create a user. A fixed date makes the output the same every run.
  final ali = User(
    id: '1',
    name: 'Ali',
    email: 'ali@example.com',
    createdAt: DateTime.utc(2026, 1, 15, 10, 30),
  );
  print('Created: ${ali.name} <${ali.email}>');

  // 2) Object -> JSON text.
  final text = jsonEncode(ali.toJson());
  print('JSON: $text');

  // 3) JSON text -> object again (a "round trip").
  final copy = User.fromJson(jsonDecode(text) as Map<String, dynamic>);
  print(
    'Round trip works: ${copy.id == ali.id && copy.createdAt == ali.createdAt}',
  );

  // 4) The default: without createdAt the current time is used.
  final sara = User(id: '2', name: 'Sara', email: 'sara@example.com');
  final ageInSeconds = DateTime.now().difference(sara.createdAt).inSeconds;
  print('createdAt defaults to now: ${ageInSeconds < 5}');

  // 5) Validation: a wrong email is rejected when the object is created.
  try {
    User(id: '3', name: 'Bad', email: 'not-an-email');
  } on ArgumentError catch (e) {
    print('Rejected: ${e.message}');
  }

  // 6) Immutability: the next line would NOT compile because name is final.
  // ali.name = 'Someone else';
}
