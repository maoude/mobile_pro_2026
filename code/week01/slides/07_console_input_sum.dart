// Week 1, slide 23 - taking integer input.
import 'dart:io';

// The package above is required for the write and readLineSync functions
void main() {
  int x, y;
  stdout.write('Enter x: ');
  x = int.parse(stdin.readLineSync()!); // ! : readLineSync may return null
  stdout.write('Enter y: ');
  y = int.parse(stdin.readLineSync()!);
  print('Sum is ${x + y}');
}
