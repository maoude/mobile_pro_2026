// =====================================================================
// Week 3 - Slides 7 to 9: Private fields, getters and setters
// =====================================================================
// WHAT YOU LEARN
//   * Code in another file cannot touch the private field _radius, but it
//     can use the getter and the setter defined by the class.
//   * The setter validates the value: a negative radius throws an
//     exception, so a Circle can never hold an invalid radius.
//   * The constructor uses the same setter, so the check also protects
//     object creation.
//
// HOW TO RUN (circle.dart must be in the same folder)
//   dart run 02_private_fields.dart
//
// EXPECTED OUTPUT
//   Radius: 10.0
//   After c1.radius = 20: 20.0
//   Exception: Invalid Radius
//   Radius is still: 20.0
//   Constructor also validates: Exception: Invalid Radius
// =====================================================================

import 'circle.dart'; // the library that defines Circle

void main() {
  // The constructor calls the radius setter.
  Circle c1 = Circle(10);
  print('Radius: ${c1.radius}'); // calls the radius GETTER

  // Calls the radius SETTER with a valid value.
  c1.radius = 20;
  print('After c1.radius = 20: ${c1.radius}');

  // An invalid value: the setter throws an exception, which we catch.
  try {
    c1.radius = -2;
  } on Exception catch (e) {
    print('$e'); // Exception: Invalid Radius
  }
  print('Radius is still: ${c1.radius}'); // the bad value was refused

  // The constructor is protected too.
  try {
    Circle(-1);
  } on Exception catch (e) {
    print('Constructor also validates: $e');
  }

  // Direct access to the private field does NOT compile in this file:
  // c1._radius = 5;   // Error: The setter '_radius' isn't defined for the type 'Circle'.
}
