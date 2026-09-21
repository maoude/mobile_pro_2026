// =====================================================================
// Week 2 - Slides 10 and 11: Lists (looping, forEach and List.filled)
// =====================================================================
// WHAT YOU LEARN
//   * A List holds items in order; the first index is 0.
//   * Two ways to visit every item: a for loop, or the forEach method,
//     which takes an anonymous function and calls it once per item.
//   * List.filled(size, value) creates a list of a FIXED length.
//   * Careful: a list written with [ ] is NOT fixed-size. It can grow
//     (only List.filled creates a fixed-length list).
//
// HOW TO RUN
//   dart run 09_fixed_size_lists.dart
//
// EXPECTED OUTPUT
//   List items using for loop...
//   red
//   green
//   blue
//   List items using forEach method...
//   red
//   green
//   blue
//   Passed grades...
//   80.0
//   60.0
//   90.0
//   A List.filled list has a fixed length: UnsupportedError
// =====================================================================

void main() {
  // ---------------- Slide 10: a list with initial items ----------------
  List<String> colors = ['red', 'green', 'blue'];

  // 1) for loop: i goes 0, 1, 2 (colors.length is 3).
  print('List items using for loop...');
  for (int i = 0; i < colors.length; i++) {
    print('${colors[i]}');
  }

  // 2) forEach: the anonymous function (e) { ... } runs once per item,
  //    and e is the current item.
  print('List items using forEach method...');
  colors.forEach((e) {
    print('$e');
  });
  // (A "for (final e in colors) { ... }" loop does the same.)

  // ---------------- Slide 11: List.filled ----------------
  // 4 items, all set to 0 (as doubles: 0.0). The length can never change.
  List<double> grades = List.filled(4, 0);
  grades[0] = 80;
  grades[1] = 60;
  grades[2] = 40;
  grades[3] = 90;

  print('Passed grades...');
  grades.forEach((e) {
    if (e >= 60) print('$e');
  });

  // The items can be replaced, but the list cannot grow or shrink.
  try {
    grades.add(100);
  } on UnsupportedError {
    print('A List.filled list has a fixed length: UnsupportedError');
  }
}
