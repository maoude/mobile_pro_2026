// Source: 002_lect_01_01.tex, section 2.1 Dart Syntax Essentials - Variable Declarations and Type System
// Pure Dart (top-level declarations; add a main() to run it).

// No imports needed for basic syntax
var inferred = 'Hello';
final runtimeFinal = DateTime.now();
const compileConst = 3.14;

// Collections with type safety
List<String> names = ['Alice', 'Bob'];
Map<String, int> scores = {'A': 95, 'B': 87};
Set<int> unique = {1, 2, 3};
