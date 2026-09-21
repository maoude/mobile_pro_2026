// =====================================================================
// Week 2 - Slide 20: Packages - the dart:math library
// =====================================================================
// WHAT YOU LEARN
//   * import 'dart:math'; adds the functions and constants of that library.
//     Dart has many libraries, and thousands more packages on pub.dev.
//   * pow(x, y) is x to the power y; sqrt(x) is the square root.
//   * min, max and pi are also in dart:math.
//
// HOW TO RUN
//   dart run 15_math_package.dart
//
// EXPECTED OUTPUT
//   2.0 to the power 25.0 is 33554432.0
//   Square root of 25.0 is 5.0
//   max(3, 7) = 7
//   min(3, 7) = 3
//   pi = 3.141592653589793
// =====================================================================

// The import goes at the top of the file, before any other code.
import 'dart:math';

void main() {
  double x = 2;
  double y = 25;

  // pow returns x to the power y. Both are doubles, so the result is 33554432.0
  print('$x to the power $y is ${pow(x, y)}');

  // sqrt returns the square root of a number.
  print('Square root of $y is ${sqrt(y)}');

  // A few more functions from the same library.
  print('max(3, 7) = ${max(3, 7)}');
  print('min(3, 7) = ${min(3, 7)}');
  print('pi = $pi');
}
