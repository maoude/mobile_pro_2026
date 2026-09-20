// =====================================================================
// Lecture 1.1, section 2.1: Variables, final/const and collections
// =====================================================================
// WHAT YOU LEARN
//   * var / final / const: three ways to declare a variable.
//       var    -> can be reassigned later (the type is inferred)
//       final  -> assigned ONCE, at run time (e.g. the current time)
//       const  -> a COMPILE-TIME constant (value known before running)
//   * The three collection types: List, Map and Set.
//   * A "final" collection can still change its CONTENT; a "const"
//     collection cannot (Flutter uses const everywhere for speed).
//
// HOW TO RUN
//   dart run 01_variables_and_collections.dart
//
// EXPECTED OUTPUT
//   inferred: Hello (String)
//   runtimeFinal was set at run time (year >= 2024): true
//   compileConst: 3.14
//   names: [Alice, Bob, Carol]
//   scores: {A: 95, B: 87}
//   unique: {1, 2, 3}
//   score of A: 95
//   finalList: [1, 2, 3]
//   constList cannot be modified
// =====================================================================

void main() {
  // ---------------- Variables ----------------
  // var: the type (String) is inferred from the value.
  var inferred = 'Hello';
  // final: the value is computed when the program runs, then never changes.
  final runtimeFinal = DateTime.now();
  // const: the value is known at compile time (a literal or const expression).
  const compileConst = 3.14;

  print('inferred: $inferred (${inferred.runtimeType})');
  print(
    'runtimeFinal was set at run time (year >= 2024): '
    '${runtimeFinal.year >= 2024}',
  );
  print('compileConst: $compileConst');

  // ---------------- Collections ----------------
  // List: ordered, can contain duplicates, accessed by position.
  List<String> names = ['Alice', 'Bob'];
  // Map: key -> value pairs, accessed by key.
  Map<String, int> scores = {'A': 95, 'B': 87};
  // Set: no duplicates. toSet() turns a list into a set, so the repeated
  // 2 and 1 in this list are dropped.
  Set<int> unique = [1, 2, 3, 2, 1].toSet();

  names.add('Carol'); // a normal (non-final) list can grow
  print('names: $names');
  print('scores: $scores');
  print('unique: $unique');
  print('score of A: ${scores['A']}');

  // ---------------- final vs const collections ----------------
  // "final" means the VARIABLE cannot point to another list,
  // but the list it points to can still be changed.
  final finalList = [1, 2];
  finalList.add(3);
  print('finalList: $finalList');

  // "const" makes the list itself unchangeable.
  const constList = [1, 2];
  try {
    constList.add(3); // not allowed: throws UnsupportedError at run time
  } on UnsupportedError {
    print('constList cannot be modified');
  }
}
