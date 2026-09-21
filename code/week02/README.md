# Week 2 - Introduction to Dart Programming

Lecture notes: `../../lectures/week02_intro.pdf`

Every file starts with a comment block that says **what you learn**, **how to run it** and
the **expected output**. Run the file, then compare what you see with that block.

## `slides/` - plain Dart, run with `dart run <file>`

| File | Slide | What it shows |
|---|---|---|
| `01_error_handling.dart` | 2 | `try` / `on FormatException`, a `do-while` loop that asks again after a mistake |
| `02_factorial_function.dart` | 3 | a function with parameters and a return value |
| `03_optional_positional_default.dart` | 4 | no overloading in Dart; optional `[ ]` parameters with a default value |
| `04_optional_positional_nullable.dart` | 5 | optional parameters without a default (`int?`), null check and `??` |
| `05_named_parameters.dart` | 6 | named `{ }` parameters, any order, `required` |
| `06_lambda_functions.dart` | 7 | arrow (`=>`) functions |
| `07_function_type.dart` | 8 | a function stored in a variable |
| `08_anonymous_functions.dart` | 9 | functions without a name, passed as arguments |
| `09_fixed_size_lists.dart` | 10, 11 | lists, `for` and `forEach`, `List.filled` |
| `10_dynamic_lists.dart` | 12, 13 | growable lists, `add` and `addAll` |
| `11_maps.dart` | 14, 15 | maps: literal and constructor, lookup by key |
| `12_generics_and_literals.dart` | 16 | `<String>[ ]` and `<String, String>{ }` |
| `13_sets.dart` | 17 | sets: unique items, intersection, union, difference |
| `14_lists_and_functions.dart` | 18, 19 | passing a list to a function and returning one |
| `15_math_package.dart` | 20 | `import 'dart:math'`: `pow`, `sqrt`, `max`, `min`, `pi` |

`01_error_handling.dart` reads the keyboard, so run it in a terminal (the Debug Console of
VS Code cannot receive typed input).

## What was checked

* Every program was run and its real output compared, line by line, with the expected output
  written in its own header comment.
* `dart analyze` reports no issues.
