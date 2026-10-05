void _checkDimensions(double width, double height) {
  if (!width.isFinite || !height.isFinite || width <= 0 || height <= 0) {
    throw ArgumentError('Dimensions must be finite and positive.');
  }
  if (!(width * height).isFinite) {
    throw ArgumentError('The area is too large.');
  }
}

/// Returns the rectangle area, in square units.
double rectangleArea(double width, double height) {
  _checkDimensions(width, height);
  return width * height;
}

/// Returns the triangle area using its base and perpendicular height.
double triangleArea(double base, double height) {
  _checkDimensions(base, height);
  return base * height / 2;
}
