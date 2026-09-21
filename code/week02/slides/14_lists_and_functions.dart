// =====================================================================
// Week 2 - Slides 18 and 19: Passing lists to functions and returning them
// =====================================================================
// WHAT YOU LEARN
//   * A list can be a parameter (List<int> numbers) and a return value
//     (List<double>), like any other type.
//   * "/" always returns a double, so no type cast is needed for the average.
//   * The same job can be done with forEach or with the shorter list
//     methods reduce() and where().
//
// HOW TO RUN
//   dart run 14_lists_and_functions.dart
//
// EXPECTED OUTPUT
//   Average is: 60.0
//   Passed grades...
//   60.0
//   70.0
//   Same with where(): [60.0, 70.0]
// =====================================================================

// Takes a list of ints, returns their average as a double.
double getAverage(List<int> numbers) {
  int sum = 0;
  numbers.forEach((e) {
    sum += e; // add each item to the running total
  });
  // int / int gives a double in Dart, so 180 / 3 = 60.0
  return sum / numbers.length;
}

// Takes a list of grades, returns a NEW list with only the passed grades.
List<double> getPassed(List<double> grades) {
  List<double> passed = <double>[]; // start with an empty list
  grades.forEach((e) {
    if (e >= 60) passed.add(e);
  });
  return passed;
}

void main() {
  // A list literal can be written directly as the argument.
  double avg = getAverage([50, 60, 70]);
  print('Average is: $avg');

  var passed = getPassed([50, 60, 70]);
  print('Passed grades...');
  passed.forEach((e) {
    print('$e');
  });

  // The same result with where(): keep only the items that pass the test.
  // toList() turns the result back into a List.
  print(
    'Same with where(): ${[50.0, 60.0, 70.0].where((g) => g >= 60).toList()}',
  );
}
