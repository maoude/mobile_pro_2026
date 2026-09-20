// =====================================================================
// Week 1 - Slide 11: Your first Dart program
// =====================================================================
// WHAT YOU LEARN
//   * Every Dart program starts at a function called main().
//   * print() writes text to the console and then adds a new line.
//   * Text (a "string") is written between quotes.
//
// HOW TO RUN
//   dart run 01_hello_world.dart
//   (or paste the code into https://dartpad.dev and press "Run")
//
// EXPECTED OUTPUT
//   hello world
// =====================================================================

// main() is the ENTRY POINT of a Dart program: Dart calls it when the
// program starts. Without a main() there is nothing to run.
// "void" means main() does not give a value back to whoever called it.
void main() {
  // A string can use single quotes ('...') or double quotes ("...").
  // print() shows the text on the console, followed by a new line.
  print('hello world');
}
