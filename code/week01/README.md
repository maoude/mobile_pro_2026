# Week 1 - Introduction to Mobile Applications using Flutter

Lecture notes: `../../lectures/week01_intro.pdf`

## `slides/` - examples from the week 1 slides

Each of these is a complete program. Run one with `dart run <file>.dart`.

| File | Slide | What it shows |
|---|---|---|
| `01_hello_world.dart` | 11 | First Dart program (`main`, `print`) |
| `02_add_numbers_var.dart` | 15 | Adding 2 numbers, types inferred with `var` |
| `03_add_numbers_typed.dart` | 15 | The same with explicit `int` types |
| `04_type_error.dart` | 16 | **Does not compile on purpose**: Dart is strongly typed |
| `05_even_numbers.dart` | 21 | `for` loop, `if`, `%` |
| `06_console_input_names.dart` | 22 | Console input with `stdin.readLineSync()`, null safety (`String?`) |
| `07_console_input_sum.dart` | 23 | `int.parse` and the null assertion operator `!` |

The two console-input programs need the Dart SDK (DartPad cannot read the console).

Running a file as a stand-alone program, as on slides 12 to 14:

```
dart test.dart                          # run it
dart compile exe -o test.exe test.dart  # compile it to an .exe (Windows)
test                                    # run the compiled program
```

## `lect_01_01/` - code from the lecture notes (`002_lect_01_01.tex`)

These are the code listings of the lecture notes, one file per listing, in lecture order.
Most of them are **excerpts**, not complete programs: each file starts with a comment
naming its section and what it needs.

- Pure Dart, no Flutter needed: `01`, `02`, `03`, `12` (add a `main()` to run them).
- Flutter widgets and apps (need a Flutter project, and some need `package:provider`
  or `package:http`): `04` to `11`, `13` to `18`, `20`.
- `19_quick_start.txt` holds the shell commands that create a Flutter project.
