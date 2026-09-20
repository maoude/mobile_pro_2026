// Week 1, slide 16 - Dart is strongly typed.
// THIS FILE DOES NOT COMPILE ON PURPOSE: x was inferred as int, so a String
// can't be assigned to it. Run it to see the compile-time error.
void main() {
  var x = 10;
  x = 'some text';
  print('Value: $x');
}
