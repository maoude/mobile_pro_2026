// =====================================================================
// Week 2 - Slide 3: Functions
// =====================================================================
// WHAT YOU LEARN
//   * A function has a return type, a name, parameters and a body:
//         int factorial(int x) { ... return f; }
//   * "return" sends a value back to the caller.
//   * The same function can be called many times with different values.
//
// HOW TO RUN
//   dart run 02_factorial_function.dart
//
// EXPECTED OUTPUT
//   Factorial of 10 is 3628800
//   Factorial of 5 is 120
//   Factorial of 0 is 1
// =====================================================================

// factorial(x) = 1 * 2 * 3 * ... * x   (and factorial(0) is defined as 1)
int factorial(int x) {
  int f = 1; // the running product, starts at 1
  // Multiply f by 2, 3, ... x. (Starting at 2 is enough: multiplying by 1
  // changes nothing.) For x = 0 or 1 the loop does not run at all.
  for (int i = 2; i <= x; i++) {
    f *= i; // same as: f = f * i;
  }
  return f; // give the result back to whoever called the function
}

void main() {
  // The call factorial(10) is replaced by the value it returns.
  print('Factorial of 10 is ${factorial(10)}');
  print('Factorial of 5 is ${factorial(5)}');
  print('Factorial of 0 is ${factorial(0)}');
}
