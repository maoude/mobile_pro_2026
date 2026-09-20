// =====================================================================
// Week 1 - Slide 23: Taking integer input
// =====================================================================
// WHAT YOU LEARN
//   * readLineSync() always returns TEXT (String?). To calculate with it
//     you must convert it to a number with int.parse().
//   * The null assertion operator "!" tells Dart: "I am sure this is not
//     null here". If you are wrong, the program stops with an error.
//   * int.parse() stops the program if the text is not a whole number.
//     (The safe alternative, int.tryParse(), returns null instead.)
//
// HOW TO RUN (needs the Dart SDK)
//   dart run 07_console_input_sum.dart
//
// EXPECTED OUTPUT (what you type is shown after the prompts)
//   Enter x: 10
//   Enter y: 20
//   Sum is 30
// =====================================================================

// The package above is required for stdin, stdout and readLineSync.
import 'dart:io';

void main() {
  int x, y; // declared now, given a value below

  stdout.write('Enter x: ');
  // 1) stdin.readLineSync() returns String? (text or null)
  // 2) "!" says "not null" so Dart treats it as a plain String
  // 3) int.parse() converts the text "10" into the number 10
  x = int.parse(stdin.readLineSync()!);

  stdout.write('Enter y: ');
  y = int.parse(stdin.readLineSync()!);

  // ${x + y} evaluates the expression inside the braces, then prints it.
  print('Sum is ${x + y}');

  // Try typing "abc": int.parse throws a FormatException and the program
  // stops. int.tryParse('abc') would return null, so you could check it:
  //   final n = int.tryParse(text);
  //   if (n == null) { print('Please type a whole number'); }
}
