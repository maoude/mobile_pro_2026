// =====================================================================
// Week 2 - Slide 5: Optional parameters without a default value
// =====================================================================
// WHAT YOU LEARN
//   * An optional parameter with no default value is null when omitted.
//   * Because Dart does not allow null in a normal type, the type must be
//     nullable: int? (an int OR null).
//   * The function then checks for null before using the value.
//   * "??" gives a shorter way to write the same check.
//
// HOW TO RUN
//   dart run 04_optional_positional_nullable.dart
//
// EXPECTED OUTPUT
//   f(10) result is: 20
//   f(10, 20) result is: 40
//   f2(10) result is: 20
//   f2(10, 20) result is: 40
// =====================================================================

// Version 1: test the optional value for null.
int f1(int x, [int? y]) {
  // y is null when the caller did not pass it. Inside this "if" Dart knows
  // that y is not null, so y can be used as a normal int.
  if (y != null) return x * 2 + y;
  return x * 2;
}

// Same behaviour, shorter: "y ?? 0" means "y, or 0 if y is null".
int f2(int x, [int? y]) => x * 2 + (y ?? 0);

void main() {
  print('f(10) result is: ${f1(10)}');
  print('f(10, 20) result is: ${f1(10, 20)}');
  print('f2(10) result is: ${f2(10)}');
  print('f2(10, 20) result is: ${f2(10, 20)}');
}
