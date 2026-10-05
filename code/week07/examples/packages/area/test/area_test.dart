import 'package:area/area.dart';
import 'package:test/test.dart';

void main() {
  test('areas retain numerical precision; formatting is separate', () {
    expect(rectangleArea(4, 3), 12);
    expect(triangleArea(4, 3), 6);
    expect(rectangleArea(0.5, 0.25), 0.125);
    expect(formatArea(12.34567), '12.3457');
    expect(formatArea(12.5, locale: 'de_DE'), '12,5');
  });
  for (final invalid in [0.0, -1.0, double.nan, double.infinity]) {
    test('rejects dimension $invalid', () {
      expect(() => rectangleArea(invalid, 3), throwsArgumentError);
      expect(() => triangleArea(3, invalid), throwsArgumentError);
    });
  }
  test('rejects an overflowing area', () {
    expect(() => rectangleArea(1e308, 1e308), throwsArgumentError);
  });
}
