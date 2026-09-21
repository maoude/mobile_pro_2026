
# Week 4, part 3 - Widgets, their types and parameters

Lecture notes: `../../lectures/week04_widgets_parameters.pdf`

The code of these notes is here, not in the PDF. `examples/` is a small Flutter project; each
`lib/NN_*.dart` file is a complete app with its own `main()`, and starts with a comment block that
says **what you learn**, **how to run it** and the **expected result** on screen.

## First time

```
cd examples
flutter pub get      # download the dependencies
flutter test         # run the automated checks: all tests should pass
flutter create .     # ONE time only: adds the android/web/windows... folders
```

`flutter create .` does not change any of the files here.

## Run an example

```
flutter run -t lib/01_widgets_full_program.dart
flutter run -t lib/03_custom_appbar.dart -d chrome
```

## The examples

| File | Notes | What you see |
|---|---|---|
| `01_widgets_full_program.dart` | sections 1 to 5 | the full program: visible widgets (`Text`, buttons, `Image`, `Icon`), layout widgets (`Row`, `Column`, `Center`, `Padding`, `Stack`, `Scaffold`) and their common parameters in one page; the last tapped button is remembered |
| `02_scaffold_bottom_bar.dart` | recipe 1 | a `Scaffold` with `backgroundColor`, a `BottomAppBar` with a notch, a docked floating button (a stateful counter) and a text field: the body follows the keyboard |
| `03_custom_appbar.dart` | recipe 3 | an `AppBar` in a class of its own: `PreferredSizeWidget`, `preferredSize`, `toolbarHeight`, `leading`, `actions`, `elevation` |
| `04_expanded_flag.dart` | recipe 4 | four `Expanded` children with no `flex` share the free height equally; `RichText` and `TextSpan` |
| `05_expanded_listview.dart` | recipe 4 | a `ListView` inside an `Expanded` in a `Column`, with a header and a footer that do not scroll |
| `06_scaffold_drawer.dart` | recipe 2 | a `Scaffold` with a `drawer` and an `endDrawer`: `DrawerHeader`, `ListTile` rows, `Navigator.pop` to close it |
| `07_cupertino_scaffold.dart` | Material and Cupertino | the iOS style: `CupertinoApp`, `CupertinoPageScaffold`, `CupertinoNavigationBar`, `CupertinoButton` |
| `08_container_effects.dart` | recipe 5 | six boxes: `margin` and `padding`, `BoxDecoration` (border, rounded corners, shadow, gradient, circle), `alignment`, `transform` |

The image `assets/logo.png` is used by example 01; the folder is declared in `pubspec.yaml`.

## Tests

`test/widget_test.dart` starts each example in a test window and checks what it shows. Some tests
check claims of the notes, for example that a `ListView` put directly in a `Column` fails with
"unbounded height" and that `Expanded` fixes it, that the `Scaffold` makes the body smaller
when the keyboard opens, that the `AppBar` adds the drawer buttons by itself, and that a
`Container` refuses both `color` and `decoration`. Run it with `flutter test`.

The other week 4 examples (the Hello World app in steps) are in `../flutter_examples`.
