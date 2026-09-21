// =====================================================================
// Week 3 - Slides 12 to 14: Class inheritance
// =====================================================================
// WHAT YOU LEARN
//   * "class Circle extends Shape" makes Circle a SUBCLASS of Shape: it
//     gets all of Shape's members (except its constructors).
//   * The subclass constructor must call the parent constructor with
//     super(...): here it passes the color up to Shape.
//   * A subclass can override a method (@override) and still reuse the
//     parent's version with super.toString().
//   * A Circle IS a Shape, so it can be stored where a Shape is expected.
//   * "is" tests the real type of an object at run time.
//
// HOW TO RUN
//   dart run 04_inheritance.dart
//
// EXPECTED OUTPUT
//   Shape: Color: green
//   Circle: Color: red Radius: 10.0
//   This shape is a plain Shape
//   This shape is a Circle with radius 10.0
//   All shapes in one list:
//   Color: green
//   Color: red Radius: 10.0
// =====================================================================

// The parent class (super class).
class Shape {
  String color;

  Shape(this.color); // sets the color field

  @override
  String toString() {
    return 'Color: $color';
  }
}

// The child class (subclass): everything in Shape, plus a radius.
class Circle extends Shape {
  double radius;

  // Circle(String color, this.radius) receives both values. After ":" the
  // parent constructor is called to store the color.
  Circle(String color, this.radius) : super(color);

  @override
  String toString() {
    // super.toString() is the parent's text ("Color: red"); we add to it.
    return '${super.toString()} Radius: $radius';
  }
}

// The parameter is a Shape, but the object may really be a Circle.
// "is Circle" checks that; inside the if, Dart lets us use x.radius.
void whatIs(Shape x) {
  if (x is Circle) {
    print('This shape is a Circle with radius ${x.radius}');
  } else {
    print('This shape is a plain Shape');
  }
}

void main() {
  // A plain Shape.
  Shape s = Shape('green');
  print('Shape: $s');

  // A Circle: the color is stored by Shape, the radius by Circle.
  Circle c = Circle('red', 10);
  print('Circle: $c');

  // A Circle can be passed wherever a Shape is expected.
  whatIs(s);
  whatIs(c);

  // A list of Shapes can hold both. For each object Dart calls ITS OWN
  // toString(): this is called polymorphism.
  List<Shape> shapes = [s, c];
  print('All shapes in one list:');
  for (final shape in shapes) {
    print(shape);
  }
}
