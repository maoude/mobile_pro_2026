// =====================================================================
// Week 1 - Slide 21: Printing the even numbers between m and n
// =====================================================================
// WHAT YOU LEARN
//   * The for loop: for (start; condition; step) { ... }
//   * if with the modulo operator: i % 2 == 0 means "i is even".
//   * Two ways to solve the same problem; the second does half the work.
//
// HOW TO RUN
//   dart run 05_even_numbers.dart
//
// EXPECTED OUTPUT
//   Method 1: test every number
//   10
//   12
//   14
//   16
//   18
//   20
//   Method 2: jump by 2
//   10
//   12
//   14
//   16
//   18
//   20
// =====================================================================

void main() {
  int m = 10; // first number of the range
  int n = 20; // last number of the range

  // ---- Method 1 (the slide): look at every number and test it ----
  print('Method 1: test every number');
  // i starts at m, the loop runs while i <= n, and i++ adds 1 each round.
  for (int i = m; i <= n; i++) {
    // % gives the remainder of a division. Even numbers leave remainder 0.
    if (i % 2 == 0) {
      // '$i' puts the value of i in a string (print(i) works as well).
      print('$i');
    }
  }

  // ---- Method 2: start at the first even number and jump by 2 ----
  // No test is needed because every number we visit is already even.
  print('Method 2: jump by 2');
  // If m is even we start at m, otherwise at the next number (m + 1).
  int firstEven = (m % 2 == 0) ? m : m + 1;
  for (int i = firstEven; i <= n; i += 2) {
    print('$i');
  }
}
