// =====================================================================
// Week 2 - Slide 7: Lambda (arrow) functions
// =====================================================================
// WHAT YOU LEARN
//   * If a function body is a single expression you can write it with
//     an arrow:   type name(parameters) => expression;
//   * The value of the expression is returned automatically, so there is
//     no "return" keyword and no { } braces.
//   * The arrow works for void functions too (like display below).
//
// HOW TO RUN
//   dart run 06_lambda_functions.dart
//
// EXPECTED OUTPUT
//   sum(10, 20) result is: 30
//   Hello Jane
//   square(7) is: 49
// =====================================================================

// Long form:  int sum(int x, int y) { return x + y; }
// Arrow form (same thing):
int sum(int x, int y) => x + y;

// The expression print(...) is evaluated; nothing is returned (void).
void display(String name) => print('Hello $name');

// Another arrow function, added as an extra example.
int square(int n) => n * n;

void main() {
  print('sum(10, 20) result is: ${sum(10, 20)}');
  display('Jane');
  print('square(7) is: ${square(7)}');
}
