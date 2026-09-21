// =====================================================================
// Week 2 - Slides 14 and 15: Maps (key / value pairs)
// =====================================================================
// WHAT YOU LEARN
//   * A Map stores pairs: you look a value up by its KEY.
//   * Create a map with a literal { key: value } or with the Map
//     constructor, then read and write with map[key].
//   * A map can grow and shrink while the program runs.
//   * Looking up a key that does not exist gives null.
//
// HOW TO RUN
//   dart run 11_maps.dart
//
// EXPECTED OUTPUT
//   Id: 101
//   Name: rami
//   {exam1: 80.0, exam2: 60.0, final: 77.0}
//   Student with id 303 grade is: 80.0
//   Student with id 999 grade is: null
//   Number of students: 4
// =====================================================================

void main() {
  // ---------------- Slide 14: a map from a literal ----------------
  // Dart infers Map<String, String> from the keys and values.
  var user = {'id': '101', 'name': 'rami'};
  print('Id: ${user['id']}');
  print('Name: ${user['name']}');

  // You can also state the key and value types yourself.
  // The numbers are written without .0 but stored as doubles.
  var exams = <String, double>{'exam1': 80, 'exam2': 60, 'final': 77};
  print(exams);

  // ---------------- Slide 15: an empty map, filled later ----------------
  // In older code you may see "new Map<int, double>()". The word "new" is
  // optional in modern Dart, so we leave it out.
  var students = Map<int, double>();
  students[101] = 70;
  students[201] = 50;
  students[303] = 80;
  students[400] = 77.5;
  print('Student with id 303 grade is: ${students[303]}');

  // A key that is not in the map gives null (no error).
  print('Student with id 999 grade is: ${students[999]}');
  print('Number of students: ${students.length}');
}
