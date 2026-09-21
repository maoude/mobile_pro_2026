// =====================================================================
// Week 3 - Slides 7 to 11: The Circle class (a library file)
// =====================================================================
// WHAT YOU LEARN
//   * PRIVATE fields: a name that starts with an underscore (_radius) can
//     only be used inside THIS FILE. In Dart, "private" means private to the
//     file (the "library"), not to the class. That is why the class lives
//     in its own file.
//   * A getter (get) and a setter (set) give controlled access to a private
//     field. The setter can VALIDATE the new value.
//   * toString() describes an object as text. Every class inherits one from
//     Object; @override replaces it with our own version.
//   * A NAMED constructor (Circle.create) is how Dart offers more than one
//     way to build an object, because Dart has no constructor overloading.
//
// HOW TO USE
//   This file has no main(), so it is not run by itself. It is imported by
//   02_private_fields.dart and 03_tostring_and_named_constructor.dart, which
//   must be in the same folder:
//       import 'circle.dart';
// =====================================================================

import 'dart:math'; // pi

class Circle {
  // Private field: the underscore hides it from every other file.
  // It starts at 0 so that it always has a value.
  double _radius = 0;

  // Main constructor. "radius = r" calls the SETTER below, so an invalid
  // radius is rejected when the object is created.
  Circle(double r) {
    radius = r;
  }

  // Named constructor: an alternative way to create a Circle (radius 5).
  // The part after ":" is the initializer list; it sets the field directly.
  Circle.create() : _radius = 5;

  // Getter: lets other files READ the private field as "c.radius".
  double get radius => _radius;

  // Setter: lets other files CHANGE the field as "c.radius = 20",
  // but only if the value is valid.
  set radius(double r) {
    if (r > 0) {
      _radius = r;
    } else {
      throw Exception('Invalid Radius');
    }
  }

  double getArea() {
    return pi * _radius * _radius;
  }

  // Called when the object is printed or used inside a string.
  @override
  String toString() {
    return 'Radius: $_radius Area: ${getArea()}';
  }
}
