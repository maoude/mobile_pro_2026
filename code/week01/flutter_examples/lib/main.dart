// =====================================================================
// Default entry point of the project: "flutter run" starts this file
// =====================================================================
// WHAT YOU LEARN
//   * Every Flutter app starts in a main() function. When you run
//     "flutter run" without "-t", Flutter uses lib/main.dart.
//   * This project has many small demos, each with its own main(). To keep
//     things simple, this file just starts example 14 (the widget tree).
//
// HOW TO RUN
//   flutter run                            (this file -> example 14)
//   flutter run -t lib/<example file>.dart (any other example)
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The word  Hello  in the centre of the page.
// =====================================================================

import '14_widget_tree.dart' as widget_tree;

// "as widget_tree" gives the import a name, so widget_tree.main() means
// "the main() of the other file" and does not clash with this main().
void main() => widget_tree.main();
