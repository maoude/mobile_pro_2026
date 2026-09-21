// =====================================================================
// Week 2 - Slide 2: Error handling with try / catch
// =====================================================================
// WHAT YOU LEARN
//   * Some errors only appear while the program runs (an "exception").
//     For example int.parse('abc') cannot turn text into a number.
//   * try { ... } on SomeError { ... } lets the program handle the error
//     instead of crashing.
//   * A do-while loop repeats until the flag says we are done: here it
//     keeps asking until the user types two valid numbers.
//
// HOW TO RUN (needs keyboard input, so use a terminal)
//   dart run 01_error_handling.dart
//
// EXPECTED OUTPUT (typed input shown; the user first types "abc")
//   Enter x: abc
//   Only numbers are allowed
//   Enter x: 10
//   Enter y: 20
//   Sum is: 30
// =====================================================================

import 'dart:io';

void main() {
  // The loop repeats while flag is true. It becomes false only after a
  // successful sum, so a typing mistake simply asks again.
  bool flag = true;

  do {
    // try: run code that might fail.
    try {
      stdout.write('Enter x: ');
      // int.parse throws a FormatException when the text is not a number.
      int x = int.parse(stdin.readLineSync()!);
      stdout.write('Enter y: ');
      int y = int.parse(stdin.readLineSync()!);
      print('Sum is: ${x + y}');
      // Reached only if NOTHING above threw an error.
      flag = false;
    } on FormatException {
      // Runs only when a FormatException happened inside the try block,
      // and then the loop continues.
      //
      // You will often see "catch (e)", which catches EVERY kind of error.
      // "on FormatException" is safer: it handles exactly the mistake we
      // expect (bad text) and lets real bugs show up.
      print('Only numbers are allowed');
    }
  } while (flag);
}
