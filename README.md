# Mobile Programming 2026 - Flutter

Course material for the mobile programming course (Dart and Flutter), 2026.

This repository grows **week by week**. The tables below list everything that is available
**so far**; this page is updated each week when new material is added.

*Last updated: 21 September 2026 (week 4).*

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
| [Lecture notes](lectures/week04_intro.pdf) | Widgets, stateless and stateful widgets, creating and running a Flutter project, the Hello World app step by step (`Scaffold`, `AppBar`, `Text`, custom widgets, `Column`, `Row`), logical pixels |
| [Running the Flutter apps in VS Code](lectures/week04_programs_vscode.pdf) | How to prepare and run the week 4 apps in VS Code, and what each step should show on the screen |
| [Code: Flutter examples](code/week04/flutter_examples) | A small Flutter project: the Hello World app in 10 runnable steps, with automated tests |

### Coming next

| Week | Status |
|---|---|
| Week 5 | to be added |
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
  week04/     flutter_examples/
```
