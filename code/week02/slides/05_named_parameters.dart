// =====================================================================
// Week 2 - Slide 6: Named function parameters
// =====================================================================
// WHAT YOU LEARN
//   * Named parameters are declared inside { }.
//   * The caller writes the NAME of each value, so the order does not
//     matter and the call is easy to read: f1(y: 10, x: 5).
//   * Named parameters are optional, so each one needs a default value,
//     or must be marked "required".
//   * Flutter widgets use named parameters everywhere (Text(...),
//     Padding(padding: ..., child: ...)).
//
// HOW TO RUN
//   dart run 05_named_parameters.dart
//
// EXPECTED OUTPUT
//   f1() result is: 0
//   f1(x: 10) result is: 10
//   f1(y: 10) result is: 30
//   f1(x: 5, y: 10) result is: 35
//   f1(y: 10, x: 5) result is: 35
//   Hello, Rami!
//   Welcome, Rami!
// =====================================================================

// Both parameters are optional and default to 0.
int f1({int x = 0, int y = 0}) {
  return x + y * 3;
}

// "required" forces the caller to give a value (no default is needed).
// greeting is optional and defaults to 'Hello'.
String greet({required String name, String greeting = 'Hello'}) {
  return '$greeting, $name!';
}

void main() {
  print('f1() result is: ${f1()}'); // both defaults: 0 + 0 * 3 = 0
  print('f1(x: 10) result is: ${f1(x: 10)}'); // 10 + 0 * 3 = 10
  print('f1(y: 10) result is: ${f1(y: 10)}'); // 0 + 10 * 3 = 30
  // With named parameters the order does not matter:
  print('f1(x: 5, y: 10) result is: ${f1(x: 5, y: 10)}'); // 5 + 30 = 35
  print('f1(y: 10, x: 5) result is: ${f1(y: 10, x: 5)}'); // 35 again

  print(greet(name: 'Rami')); // greeting uses its default
  print(greet(greeting: 'Welcome', name: 'Rami')); // any order
  // greet() with no name would NOT compile: name is required.
}
