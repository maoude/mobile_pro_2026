// Week 1, slide 22 - console input. Needs the Dart SDK (DartPad has no console input).
import 'dart:io';

// The package above is required for the write and readLineSync functions
void main() {
  String? first, last; // we need ? because its value may be null
  stdout.write('Enter first name: '); // write does not add a new line
  first = stdin.readLineSync(); // this waits for user input
  stdout.write('Enter last name: ');
  last = stdin.readLineSync();
  print('Welcome $first $last');
}
