// =====================================================================
// Lecture 1.1, section 2.1: Control flow and pattern matching (Dart 3)
// =====================================================================
// WHAT YOU LEARN
//   * A switch EXPRESSION returns a value ("=>" instead of case/break).
//   * "||" lets several patterns share one result.
//   * "_" is the wildcard: it matches everything not matched before.
//   * Relational patterns (>= 90) make ranges easy to write.
//
// HOW TO RUN
//   dart run 02_switch_pattern_matching.dart
//
// EXPECTED OUTPUT
//   Flutter -> Cross-platform
//   React Native -> Cross-platform
//   SwiftUI -> iOS Native
//   UIKit -> iOS Native
//   Jetpack Compose -> Android Native
//   Xamarin -> Unknown
//   Score 95 -> A
//   Score 85 -> B
//   Score 72 -> C
//   Score 40 -> F
// =====================================================================

// A switch expression: it evaluates to a String, so we can use "=>"
// as a short form of "return switch (...) { ... };".
String kindOf(String framework) => switch (framework) {
  'Flutter' || 'React Native' => 'Cross-platform', // two patterns, one result
  'SwiftUI' || 'UIKit' => 'iOS Native',
  'Jetpack Compose' => 'Android Native',
  _ => 'Unknown', // wildcard: anything else
};

// Relational patterns: the cases are checked from top to bottom, so
// 95 matches ">= 90" first and never reaches the later cases.
String grade(int score) => switch (score) {
  >= 90 => 'A',
  >= 80 => 'B',
  >= 70 => 'C',
  _ => 'F',
};

void main() {
  const frameworks = [
    'Flutter',
    'React Native',
    'SwiftUI',
    'UIKit',
    'Jetpack Compose',
    'Xamarin',
  ];
  for (final f in frameworks) {
    print('$f -> ${kindOf(f)}');
  }

  for (final score in [95, 85, 72, 40]) {
    print('Score $score -> ${grade(score)}');
  }
}
