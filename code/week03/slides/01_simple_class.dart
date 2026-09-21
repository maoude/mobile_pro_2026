// =====================================================================
// Week 3 - Slides 4 to 6: A simple class and its objects
// =====================================================================
// WHAT YOU LEARN
//   * A class describes a kind of object: it has FIELDS (data) and
//     METHODS (actions). Here a Circle has a radius and can compute its area.
//   * The constructor Circle(this.radius) is a shorthand: it copies the
//     argument into the field, so you do not write "radius = r;" yourself.
//   * You create an object by calling the class like a function:
//     Circle(10). Unlike Java, there is no "new" keyword.
//   * Every field automatically gets a getter and a setter: c1.radius reads
//     it and c1.radius = 20 changes it. (In Java you would write
//     getRadius() and setRadius(20).)
//
// Compare with the Java version of the same class:
//     public class Circle {
//         double radius;
//         public Circle(double r) { radius = r; }
//         public double getArea() { return radius * radius * Math.PI; }
//     }
//
// HOW TO RUN
//   dart run 01_simple_class.dart
//
// EXPECTED OUTPUT
//   Radius: 10.0
//   Area: 314.1592653589793
//   New radius: 20.0
//   New area: 1256.6370614359173
// =====================================================================

import 'dart:math'; // gives us pi

class Circle {
  double radius; // a field: each Circle object has its own radius

  // Constructor. "this.radius" means: store the argument in the field radius.
  Circle(this.radius);

  // A method: returns the area of the circle.
  double getArea() {
    return pi * radius * radius;
  }
}

void main() {
  // Create a Circle object with radius 10 (no "new" needed).
  // The 10 is written as an int but stored as a double: 10.0
  Circle c1 = Circle(10);

  // Reading the field calls its implicit getter.
  print('Radius: ${c1.radius}');
  print('Area: ${c1.getArea()}');

  // Assigning to the field calls its implicit setter.
  c1.radius = 20;
  print('New radius: ${c1.radius}');
  print('New area: ${c1.getArea()}');
}
