// =====================================================================
// Week 3 - Slides 10 and 11: toString() and named constructors
// =====================================================================
// WHAT YOU LEARN
//   * toString() is called automatically when an object is printed or put
//     inside a string ('$c1'). If a class does not define one, it inherits
//     the default from Object (which prints something like "Instance of
//     'Circle'"); all classes in Dart inherit from Object.
//   * A named constructor such as Circle.create() gives a class several
//     ways to be built. It is how Dart replaces constructor overloading.
//
// HOW TO RUN (circle.dart must be in the same folder)
//   dart run 03_tostring_and_named_constructor.dart
//
// EXPECTED OUTPUT
//   c1 -> Radius: 10.0 Area: 314.1592653589793
//   c2 -> Radius: 5.0 Area: 78.53981633974483
//   Same text with toString(): Radius: 5.0 Area: 78.53981633974483
// =====================================================================

import 'circle.dart';

void main() {
  // The main constructor: the radius is given by the caller.
  Circle c1 = Circle(10);
  print('c1 -> $c1'); // $c1 calls c1.toString()

  // The named constructor: no argument, the radius is always 5.
  Circle c2 = Circle.create();
  print('c2 -> $c2');

  // Calling toString() explicitly gives the same text.
  print('Same text with toString(): ${c2.toString()}');
}
