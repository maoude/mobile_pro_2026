// =====================================================================
// Week 2 - Slide 8: Function is a type
// =====================================================================
// WHAT YOU LEARN
//   * In Dart a function is a VALUE, like a number or a String. You can
//     store it in a variable and call it later.
//   * sayHello (no parentheses) is the function itself.
//     sayHello() (with parentheses) CALLS it and gives its result.
//
// HOW TO RUN
//   dart run 07_function_type.dart
//
// EXPECTED OUTPUT
//   Hello world!
//   Hello world!
//   HELLO WORLD!
// =====================================================================

String sayHello() {
  return 'Hello world!';
}

void main() {
  // No parentheses after sayHello: we store the FUNCTION, we do not run it.
  var sayHelloFunction = sayHello;

  // Now the variable can be called like the function itself.
  print(sayHelloFunction()); // prints Hello world!

  // The type can be written out too: "a function with no parameters that
  // returns a String" is   String Function()
  String Function() again = sayHello;
  print(again());

  // A function value can be passed around like any other value.
  String Function() loud = () => sayHello().toUpperCase();
  print(loud());
}
