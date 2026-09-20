// Source: 002_lect_01_01.tex, section 2.1 Dart Syntax Essentials - Control Flow and Pattern Matching
// Pure Dart 3 (needs a main() that calls kindOf).

// Dart 3 pattern matching in switch
String kindOf(String framework) => switch (framework) {
  'Flutter' || 'React Native' => 'Cross-platform',
  'SwiftUI' || 'UIKit' => 'iOS Native',
  'Jetpack Compose' => 'Android Native',
  _ => 'Unknown',
};
