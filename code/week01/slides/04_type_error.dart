// =====================================================================
// Week 1 - Slide 16: Dart is a strongly typed language
// =====================================================================
// WHAT YOU LEARN
//   * Once Dart infers a variable's type, you cannot store a value of a
//     different type in it. The mistake is caught BEFORE the program runs
//     (a compile-time error), not while it is running.
//   * "dynamic" is the (rarely used) escape hatch: the type may change.
//
// HOW TO RUN
//   dart run 04_type_error.dart
//
// EXPECTED OUTPUT
//   Value: 10
//   Value: 20
//   dynamic can change type: some text
//
// TRY IT - see the compile-time error from the slide:
//   1. Remove the two slashes at the start of the line marked "TRY IT".
//   2. Run the program again. Dart refuses to run it and prints:
//        Error: A value of type 'String' can't be assigned to a variable
//        of type 'int'.
//   3. Put the slashes back to fix it.
// =====================================================================

void main() {
  // The value 10 is an int, so Dart decides that x can only hold ints.
  var x = 10;
  print('Value: $x');

  // TRY IT: uncomment the next line to get the compile-time error.
  // x = 'some text';

  // Assigning another int is fine: the type did not change.
  x = 20;
  print('Value: $x');

  // With "dynamic" Dart stops checking the type, so it may change freely.
  // Avoid it in real code: you lose the safety that typing gives you.
  dynamic anything = 10;
  anything = 'some text';
  print('dynamic can change type: $anything');
}
