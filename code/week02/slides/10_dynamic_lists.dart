// =====================================================================
// Week 2 - Slides 12 and 13: Dynamic (growable) lists, add and addAll
// =====================================================================
// WHAT YOU LEARN
//   * [] creates an empty list that can grow: use add() for one item.
//   * addAll() adds every item of another list at the end.
//   * Give the list a type (List<int>, List<String>) so Dart can check
//     what you put in it.
//
// HOW TO RUN
//   dart run 10_dynamic_lists.dart
//
// EXPECTED OUTPUT
//   Even numbers...
//   6
//   4
//   Number of items: 4
//   [Welcome, to, CSCI410]
// =====================================================================

void main() {
  // ---------------- Slide 12: add ----------------
  List<int> numbers = []; // empty, and it can grow
  numbers.add(6);
  numbers.add(9);
  numbers.add(1);
  numbers.add(4);

  // Print the even numbers only.
  print('Even numbers...');
  numbers.forEach((e) {
    if (e % 2 == 0) print('$e');
  });
  print('Number of items: ${numbers.length}');

  // ---------------- Slide 13: addAll ----------------
  // Always give the list a type: List<String> lets Dart check that every
  // item is a String (a plain "List" would accept anything).
  List<String> l1 = ['Welcome', 'to'];
  List<String> l2 = ['CSCI410'];

  // Add all items of l2 to the end of l1. l2 itself does not change.
  l1.addAll(l2);
  print(l1);
}
