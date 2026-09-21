// =====================================================================
// Week 2 - Slide 4: "Overloading" with optional parameters (default value)
// =====================================================================
// WHAT YOU LEARN
//   * Dart does NOT support function overloading: you cannot declare two
//     functions with the same name and different parameters.
//   * Instead, put OPTIONAL positional parameters inside [ ] and give them
//     a default value with "=". The caller may leave them out.
//   * Optional positional parameters must come last, and are given in order.
//
// HOW TO RUN
//   dart run 03_optional_positional_default.dart
//
// EXPECTED OUTPUT
//   f(10) 20
//   f(10, 20) 40
// =====================================================================

// x is required. y is optional: if the caller omits it, y is 0.
// So one function does the job of two "overloaded" versions.
int f1(int x, [int y = 0]) {
  return x * 2 + y;
}

void main() {
  // y is omitted -> y = 0 -> 10 * 2 + 0 = 20
  print('f(10) ${f1(10)}');
  // y is given -> 10 * 2 + 20 = 40
  print('f(10, 20) ${f1(10, 20)}');
}
