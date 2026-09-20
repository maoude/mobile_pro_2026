// =====================================================================
// Week 1 - Slide 15 (left code): Adding 2 numbers with type inference
// =====================================================================
// WHAT YOU LEARN
//   * "var" lets Dart INFER the type of a variable from its first value.
//   * String interpolation: $name or ${expression} inside a string.
//   * Dart is strongly typed even when you do not write the type.
//
// HOW TO RUN
//   dart run 02_add_numbers_var.dart
//
// EXPECTED OUTPUT
//   Result: 30
//   Type of x: int
//   Type of sum: int
// =====================================================================

void main() {
  // "var" means "work out the type for me".
  // 10 is a whole number, so Dart decides that x is an int.
  var x = 10;
  var y = 20;

  // int + int gives an int, so sum is inferred to be an int too.
  var sum = x + y;

  // print() adds a new line after the text it prints.
  // Inside a string, $sum is replaced by the VALUE of the variable sum.
  print('Result: $sum');

  // Use ${...} when you need more than just a variable name, for example
  // a property such as x.runtimeType. runtimeType shows the type Dart
  // inferred, even though we never wrote "int" ourselves.
  print('Type of x: ${x.runtimeType}');
  print('Type of sum: ${sum.runtimeType}');
}
