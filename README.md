# Mobile Programming 2026 - Flutter

Course material for the mobile programming course (Dart and Flutter), 2026.

This repository grows **week by week**. The tables below list everything that is available
**so far**; this page is updated each week when new material is added.

*Last updated: 21 September 2026 (week 5).*

## Course material so far

### Setup

| Material | Description |
|---|---|
| [Install guide - Android Studio edition](lectures/001_install.pdf) | Set up Flutter with Android Studio on Windows, macOS or Linux |
| [Install guide - VS Code edition](lectures/001_install_vscode.pdf) | Set up Flutter with Visual Studio Code, with or without Android Studio |

### Week 1 - Introduction to Mobile Applications using Flutter

| Material | Description |
|---|---|
| [Lecture notes](lectures/week01_intro.pdf) | What the course covers, Dart, Flutter, Git and GitHub, your first Dart programs, console input |
| [Running the programs in VS Code](lectures/week01_programs_vscode.pdf) | How to run every week 1 program in VS Code, with a short description of each one |
| [Code: slide examples](code/week01/slides) | 7 Dart programs from the slides (hello world, variables and types, loops, console input) |
| [Code: lecture examples](code/week01/lect_01_01) | 8 Dart programs from the lecture notes (collections, patterns, classes, async, streams, null safety, extensions, records) and the quick-start commands |
| [Code: Flutter examples](code/week01/flutter_examples) | A small Flutter project with 11 widget examples and automated tests |

### Week 2 - Introduction to Dart Programming

| Material | Description |
|---|---|
| [Lecture notes](lectures/week02_intro.pdf) | Error handling, functions (optional, named, lambda, anonymous), lists, maps, sets, generics, the math package |
| [Running the programs in VS Code](lectures/week02_programs_vscode.pdf) | How to run every week 2 program in VS Code, with a short description and the expected output of each one |
| [Code: slide examples](code/week02/slides) | 15 Dart programs from the slides, each with its expected output |

### Week 3 - Intermediate Dart Programming

| Material | Description |
|---|---|
| [Lecture notes](lectures/week03_intro.pdf) | Classes and objects, constructors, private fields, getters and setters, `toString`, named constructors, inheritance |
| [Running the programs in VS Code](lectures/week03_programs_vscode.pdf) | How to run every week 3 program in VS Code, with a short description and the expected output of each one |
| [Code: slide examples](code/week03/slides) | 4 Dart programs and the `circle.dart` library, each with its expected output |

### Week 4 - An Introduction to Flutter

| Material | Description |
|---|---|
| [Lecture notes](lectures/week04_intro.pdf) | Widgets, stateless and stateful widgets, creating and running a Flutter project, the Hello World app step by step (`Scaffold`, `AppBar`, `Text`, custom widgets, `Column`, `Row`), logical pixels, and going further: more `AppBar` and `Scaffold` options, `Expanded` |
| [Part 2: Flutter architecture and widget types](lectures/week04_architecture_widgets.pdf) | The layers of Flutter (embedder, engine, framework), the widget tree and how to print it, visible and layout widgets, `GestureDetector`, stateless and stateful widgets |
| [Part 3: Widgets, their types and parameters](lectures/week04_widgets_parameters.pdf) | The two types of widgets (visible and layout) and the main parameters of `Text`, buttons, `Image`, `Icon`, `Row`, `Column`, `Center`, `Padding`, `Stack`, `Scaffold`; Material and Cupertino; recipes on `Scaffold` (bottom bar, drawer), a custom `AppBar`, `Expanded` with `ListView`, and `Container` with `BoxDecoration`; a guide to the code in the `examples` project; exercises |
| [Running the Flutter apps in VS Code](lectures/week04_programs_vscode.pdf) | How to prepare and run the week 4 apps in VS Code, and what each step should show on the screen |
| [Code: Flutter examples](code/week04/flutter_examples) | A small Flutter project: the Hello World app in 10 runnable steps, plus 6 more examples (`AppBar` options, `Scaffold` extras, `Expanded`, widget types, gestures, the widget-tree dump), with automated tests |
| [Code: part 3 examples](code/week04/examples) | A second small Flutter project for part 3: the full widgets program, and recipes on `Scaffold` with a bottom bar and a drawer, the Cupertino style, a custom `AppBar`, `Expanded` and `ListView`, and `Container`, with automated tests |

### Week 5 - Creating Interactive Applications

| Material | Description |
|---|---|
| [Lecture notes](lectures/week05_intro.pdf) | Stateful widgets and `setState`, the `State` life cycle (`initState`, `build`, `dispose`, ...), the `TextField` (`onChanged`, `onSubmitted`, `InputDecoration`), your first interactive app, spreading an app over several files, a custom `TextField` widget and callbacks, the sum app, buttons and `ElevatedButton` styling, a complete Stopwatch app (`Timer`, buttons, laps), scrolling with `ListView`; going further: `TextEditingController`, reading numbers safely |
| [Part 2: Gestures and state](lectures/week05_gestures_state.pdf) | The two levels of Flutter gestures (pointer events with `Listener`, gestures with `GestureDetector`), tap, double tap, long press, drag, pan, pinch, the gesture arena; state: ephemeral state, lifting state up, `ChangeNotifier`, the `provider` package; corrections to the printed text, common errors, exercises |
| [Part 3: Forms and validation](lectures/week05_forms_validation.pdf) | `DropdownButton` (`items`, `value`, `onChanged`); grouping fields with `Form` and reaching them with `GlobalKey<FormState>`; validating a `TextFormField`; running every field's validator with `validate()` and clearing a form with `reset()`; composing small validator functions; `AutovalidateMode`; restricting typing with `inputFormatters`; `TextEditingController.addListener`; `Form.of(context)`; writing a custom `FormField<T>`; corrections to the printed text (verified compile errors under null safety), common errors, exercises |
| [Running the Flutter apps in VS Code](lectures/week05_programs_vscode.pdf) | How to prepare and run the week 5 apps in VS Code, and what each one should show on the screen |
| [Code: Flutter examples](code/week05/flutter_examples) | A small Flutter project: 14 runnable examples (stateful counter, `setState`, `TextField`, custom widget, the sum app in several files, controllers, button styles, safe number input, the `State` life cycle, the Stopwatch app in 3 steps, scrolling), with automated tests |
| [Code: parts 2 and 3 examples](code/week05/examples) | A second small Flutter project for parts 2 and 3: 17 runnable examples (pointer events, tap, drag, pan, pinch, the gesture arena, ephemeral state, lifting state up, `ChangeNotifier`, `provider`, `DropdownButton`, `Form` validation, composed validators, `inputFormatters`, controller listeners, `Form.of`, a custom `FormField`), with automated tests |

### Coming next

| Week | Status |
|---|---|
| Week 6 | to be added |
| Later weeks | to be added week by week |

## How to use this repository

1. Install Flutter (it includes Dart) with one of the install guides above.
2. Get the code: `git clone https://github.com/maoude/mobile_pro_2026.git`
   (already cloned? Run `git pull` to get the new weeks.)
3. Open the folder in VS Code, then follow *Running the programs in VS Code* for the week.

Every program file starts with a comment block that says **what you learn**, **how to run it**
and the **expected output**. Run the program, then compare your result with that block.

## Repository layout

```
lectures/     PDFs: install guides, lecture notes, guides (one set per week)
code/         code for each week
  week01/     slides/  lect_01_01/  flutter_examples/
  week02/     slides/
  week03/     slides/
  week04/     flutter_examples/  examples/
  week05/     flutter_examples/  examples/
```
