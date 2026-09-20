# Week 1 - Introduction to Mobile Applications using Flutter

Lecture notes: `../../lectures/week01_intro.pdf`

Every file starts with a comment block that says **what you learn**, **how to run it** and
the **expected output** (or expected result on screen). Run the file, then compare what you
see with that block.

```
week01/
  slides/            programs from the week 1 slides (plain Dart)
  lect_01_01/        programs from the lecture notes (plain Dart) + a shell-commands file
  flutter_examples/  the Flutter widgets from the lecture notes (a small Flutter project)
```

## 1. `slides/` - plain Dart, run with `dart run <file>`

| File | Slide | What it shows |
|---|---|---|
| `01_hello_world.dart` | 11 | `main`, `print` |
| `02_add_numbers_var.dart` | 15 | `var`, type inference, `$` interpolation |
| `03_add_numbers_typed.dart` | 15 | explicit types, `/` versus `~/` |
| `04_type_error.dart` | 16 | strong typing (uncomment one line to see the compile error) |
| `05_even_numbers.dart` | 21 | `for`, `if`, `%` (two methods) |
| `06_console_input_names.dart` | 22 | `stdin.readLineSync()`, `String?` |
| `07_console_input_sum.dart` | 23 | `int.parse`, the `!` operator |

Slides 12 to 14 show how to run a Dart file outside an editor:

```
dart test.dart                          # run it
dart compile exe -o test.exe test.dart  # compile it to an .exe (Windows)
test                                    # run the compiled program
```

`06` and `07` read the keyboard, so they need the Dart SDK (DartPad has no console input).

## 2. `lect_01_01/` - plain Dart, run with `dart run <file>`

Code from the lecture notes (`002_lect_01_01.tex`), completed with a `main()` so that each
file runs on its own. The numbers are the listing numbers of the lecture notes; the Flutter
listings (04, 05, 07, 10, 11, 13 to 18, 20) are in `flutter_examples/`.

| File | Topic |
|---|---|
| `01_variables_and_collections.dart` | `var` / `final` / `const`, List, Map, Set |
| `02_switch_pattern_matching.dart` | Dart 3 switch expressions and patterns |
| `03_user_model.dart` | immutable class, named parameters, JSON |
| `06_futures_async_await.dart` | `Future`, `async`/`await`, `Future.wait` (network calls are simulated) |
| `08_streams_and_cleanup.dart` | `Stream`, `StreamController`, cleanup |
| `09_null_safety_basics.dart` | `?`, `??`, `?.`, `late` |
| `12_extension_methods.dart` | extension methods |
| `13_records_and_sealed_classes.dart` | records and sealed classes |
| `19_quick_start.txt` | the shell commands that create and run a Flutter project |

## 3. `flutter_examples/` - Flutter widgets

A small Flutter project with one runnable file per lecture listing. See its own
`README.md` for how to run the examples and the automated tests.

## What was checked

* Every program in `slides/` and `lect_01_01/` was run and its real output compared, line by
  line, with the expected output written in its own header comment.
* `dart analyze` reports no issues for `slides/` and `lect_01_01/`.
* `flutter analyze` reports no issues and `flutter test` passes for `flutter_examples/`.
