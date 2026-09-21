# Week 3 - Intermediate Dart Programming

Lecture notes: `../../lectures/week03_intro.pdf`

Every file starts with a comment block that says **what you learn**, **how to run it** and
the **expected output**. Run the file, then compare what you see with that block.

## `slides/` - plain Dart, run with `dart run <file>`

| File | Slides | What it shows |
|---|---|---|
| `01_simple_class.dart` | 4 to 6 | a class, the constructor shorthand `Circle(this.radius)`, creating objects, implicit getters and setters |
| `circle.dart` | 7 to 11 | the `Circle` library: private field `_radius`, getter and setter with validation, `toString`, named constructor |
| `02_private_fields.dart` | 7 to 9 | using `Circle` from another file: getter, setter, exception for an invalid radius |
| `03_tostring_and_named_constructor.dart` | 10, 11 | `toString` and the named constructor `Circle.create()` |
| `04_inheritance.dart` | 12 to 14 | `extends`, `super(...)`, `@override`, `is`, a list of shapes |

`02_private_fields.dart` and `03_tostring_and_named_constructor.dart` import `circle.dart`, so
the three files must stay in the same folder. `circle.dart` has no `main()`: it is a library
and is not run by itself.

## What was checked

* Every program with an expected output was run and its real output compared, line by line,
  with the expected output written in its own header comment.
* `dart analyze` reports no issues.
