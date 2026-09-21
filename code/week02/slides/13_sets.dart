// =====================================================================
// Week 2 - Slide 17: Sets
// =====================================================================
// WHAT YOU LEARN
//   * A Set holds UNIQUE items: adding an item that is already there
//     changes nothing.
//   * Sets are written with { } and a type: <String>{ ... }.
//     (An empty {} without a type is a Map, not a Set.)
//   * Sets support mathematical operations: intersection (in both),
//     union (in either) and difference (in the first but not the second).
//
// HOW TO RUN
//   dart run 13_sets.dart
//
// EXPECTED OUTPUT
//   Intersection: {A, B}
//   Union: {A, B, C, E}
//   Difference: {C}
//   Adding 'A' again: false
//   Adding 'Z': true
// =====================================================================

void main() {
  final characters1 = <String>{'A', 'B', 'C'};
  final characters2 = <String>{'A', 'E', 'B'};

  // Items found in BOTH sets.
  final Set<String> intersectionSet = characters1.intersection(characters2);
  print('Intersection: $intersectionSet');

  // Items found in EITHER set (no duplicates).
  print('Union: ${characters1.union(characters2)}');

  // Items in characters1 that are not in characters2.
  print('Difference: ${characters1.difference(characters2)}');

  // add() returns true if the item was new, false if it was already there.
  print("Adding 'A' again: ${characters1.add('A')}");
  print("Adding 'Z': ${characters1.add('Z')}");
}
