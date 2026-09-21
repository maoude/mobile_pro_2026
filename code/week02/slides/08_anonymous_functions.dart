// =====================================================================
// Week 2 - Slide 9: Anonymous functions
// =====================================================================
// WHAT YOU LEARN
//   * An anonymous function has no name. You write it right where it is
//     needed, usually to pass it to another function.
//   * A parameter can have a function type. "int Function(int) f" means:
//     f is a function that takes one int and returns an int.
//   * The receiving function decides when (and how often) to call it.
//   * Flutter uses this everywhere: onPressed: () { ... }
//
// HOW TO RUN
//   dart run 08_anonymous_functions.dart
//
// EXPECTED OUTPUT
//   Result: 110
//   Result: 21
//   triple(4) is: 12
// =====================================================================

// f is a function parameter of type "int Function(int)": a function that
// takes one int and returns an int. (Writing just "Function(int)" also
// compiles, but then Dart does not know what f returns.)
void display(int Function(int) f, int y) {
  // call f with y, then add y to what f returned
  print('Result: ${f(y) + y}');
}

void main() {
  // The function body is written at the place where it is passed.
  // For y = 10 the function returns 10 * 10 = 100, then display adds 10.
  display((int x) {
    return x * x;
  }, 10);

  // Same idea with an arrow function: it returns x + 1 = 11, plus 10 = 21.
  display((x) => x + 1, 10);

  // An anonymous function can also be stored in a variable.
  var triple = (int n) => n * 3;
  print('triple(4) is: ${triple(4)}');
}
