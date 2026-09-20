// Source: 002_lect_01_01.tex, section 2.4 Null Safety and Modern Dart - Extension Methods
// Pure Dart (add a main() to try the extensions).

extension StringX on String {
  bool get isValidEmail => contains('@') && contains('.');
  String capitalizeFirst() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

// Example sizing helper (conceptual)
const double kScale = 1.0; // replace with real scale logic

extension PX on double {
  double get px => this * kScale;
}
