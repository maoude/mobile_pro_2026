// =====================================================================
// Lecture 1.1, section 2.4: Extension methods
// =====================================================================
// WHAT YOU LEARN
//   * An extension ADDS new methods/getters to an existing type (String,
//     double...) without changing that type or making a subclass.
//   * Flutter code uses this a lot, for example 20.0.px for responsive sizes.
//
// HOW TO RUN
//   dart run 12_extension_methods.dart
//
// EXPECTED OUTPUT
//   ali@example.com is a valid email: true
//   ali is a valid email: false
//   capitalizeFirst: dart -> Dart
//   capitalizeFirst of an empty string is empty: true
//   20.0.px = 30.0
// =====================================================================

// Adds two members to every String.
extension StringX on String {
  // A getter: used without parentheses, like a property.
  // (A very simple check, good enough for a demo: it is NOT a full
  // email validator.)
  bool get isValidEmail => contains('@') && contains('.');

  // A method: "this" is the String the method is called on.
  String capitalizeFirst() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

// A sizing helper. In a real app kScale would come from the screen size;
// the lecture used 1.0, here 1.5 makes the effect visible.
const double kScale = 1.5;

// Adds a getter to every double: 20.0.px multiplies by the scale.
extension PX on double {
  double get px => this * kScale;
}

void main() {
  const good = 'ali@example.com';
  const bad = 'ali';
  print('$good is a valid email: ${good.isValidEmail}');
  print('$bad is a valid email: ${bad.isValidEmail}');

  const word = 'dart';
  print('capitalizeFirst: $word -> ${word.capitalizeFirst()}');
  print(
    'capitalizeFirst of an empty string is empty: ${''.capitalizeFirst().isEmpty}',
  );

  // The extension works on a double literal.
  print('20.0.px = ${20.0.px}');
}
