import 'package:intl/intl.dart';

/// Formats a finite value to at most four decimal places in the given locale.
String formatArea(double value, {String locale = 'en_US'}) {
  if (!value.isFinite) throw ArgumentError('Area must be finite.');
  return NumberFormat('0.####', locale).format(value);
}
