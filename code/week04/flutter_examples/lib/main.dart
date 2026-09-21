// =====================================================================
// Default entry point of the project: "flutter run" starts this file
// =====================================================================
// WHAT YOU LEARN
//   * Every Flutter app starts in a main() function. "flutter run" without
//     "-t" uses lib/main.dart.
//   * This project has one small app per step of the lecture, each with its
//     own main(). This file starts the FINAL step (08_row.dart).
//
// HOW TO RUN
//   flutter run                            (this file -> example 08)
//   flutter run -t lib/<example file>.dart (any other step)
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The app of 08_row.dart: the "Home Page" bar, Text 1, Text 2 and, on one
//   line, Text 3, Text 4 and Text 5.
// =====================================================================

import '08_row.dart' as final_step;

// "as final_step" names the import, so final_step.main() is the main() of
// the other file and does not clash with this main().
void main() => final_step.main();
