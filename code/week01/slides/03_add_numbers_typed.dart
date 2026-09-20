// =====================================================================
// Week 1 - Slide 15 (right code): the same program with explicit types
// =====================================================================
// WHAT YOU LEARN
//   * You may write the type yourself for clarity (int, double, String...).
//   * "/" always gives a double, even when both operands are int (slide 17).
//   * "~/" is integer division: it gives only the whole-number part.
//
// HOW TO RUN
//   dart run 03_add_numbers_typed.dart
//
// EXPECTED OUTPUT
//   Result: 30
//   Average (/): 15.0
//   Integer division (~/): 15
// =====================================================================

void main() {
  // Declaring the type explicitly: the reader sees at once what each
  // variable holds. It behaves exactly like the "var" version.
  int x = 10;
  int y = 20;
  int sum = x + y;

  // $ makes Dart use the variable's value and convert it to a string.
  print('Result: $sum');

  // "/" is the normal division and always produces a double,
  // so the result must be stored in a double (or a var).
  double average = sum / 2;
  print('Average (/): $average'); // 15.0 (note the ".0")

  // "~/" divides and throws away the fractional part; the result is an int.
  int whole = sum ~/ 2;
  print('Integer division (~/): $whole');
}
