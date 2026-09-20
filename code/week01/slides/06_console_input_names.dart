// =====================================================================
// Week 1 - Slide 22: Console input (reading text typed by the user)
// =====================================================================
// WHAT YOU LEARN
//   * import 'dart:io' gives access to stdin (keyboard) and stdout (screen).
//   * stdout.write() prints WITHOUT a new line; print() adds one.
//   * stdin.readLineSync() waits for the user to type a line + Enter.
//   * Null safety: readLineSync() may return null (for example when the
//     input ends), so the variables that receive it must be String? .
//
// HOW TO RUN (needs the Dart SDK; DartPad cannot read the keyboard)
//   dart run 06_console_input_names.dart
//
// EXPECTED OUTPUT (what you type is shown after the prompts)
//   Enter first name: Ali
//   Enter last name: Khan
//   Welcome Ali Khan
// =====================================================================

// The package above is required for stdin, stdout and readLineSync.
import 'dart:io';

void main() {
  // The "?" after String means "a String OR null". It is required because
  // readLineSync() can return null.
  String? first, last;

  // stdout.write() does not add a new line, so the user types on the
  // same line as the question.
  stdout.write('Enter first name: ');
  first = stdin.readLineSync(); // waits here until the user presses Enter

  stdout.write('Enter last name: ');
  last = stdin.readLineSync();

  // If the input was closed instead of typed, first/last would be null and
  // the message would show the word "null".
  print('Welcome $first $last');
}
