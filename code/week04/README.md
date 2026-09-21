# Week 4 - An Introduction to Flutter

Lecture notes: `../../lectures/week04_intro.pdf`

`flutter_examples/` is a small Flutter project. It builds the Hello World application of the
lecture step by step; each `lib/NN_*.dart` file is a complete app with its own `main()`, and
starts with a comment block that says **what you learn**, **how to run it** and the
**expected result** on screen.

## First time

```
cd flutter_examples
flutter pub get      # download the dependencies
flutter test         # run the automated checks: all tests should pass
flutter create .     # ONE time only: adds the android/web/windows... folders
```

`flutter create .` does not change any of the files here.

## Run an example

```
flutter run                              # lib/main.dart -> the last step (08)
flutter run -t lib/05_text_style.dart    # any other step
flutter run -t lib/02_hello_text.dart -d chrome
```

## The examples

| File | Slides | What you see |
|---|---|---|
| `00_stateless_vs_stateful.dart` | 2 to 4 | a stateless text and a stateful checkbox that changes its label when tapped |
| `01_hello_container.dart` | 10 to 12 | the smallest app: a white screen (`runApp`, `StatelessWidget`, `Container`) |
| `02_hello_text.dart` | 13 to 15 | "Hello World" with `MaterialApp`, `Center`, `Text`, in the warning style (red, underlined) |
| `03_scaffold.dart` | 16 | the same text inside a `Scaffold`: a normal style |
| `04_appbar.dart` | 17 | an `AppBar` with the centered title "Home Page" |
| `05_text_style.dart` | 18 | a `TextStyle`: size 24, deep purple |
| `06_custom_widget.dart` | 19 to 22 | a custom widget `MyTextWidget(text: ...)` |
| `07_column.dart` | 23 | two texts one below the other (`Column`, `SizedBox`) |
| `08_row.dart` | 24 | a `Row` with three texts spread evenly, inside the `Column` |
| `09_logical_pixels.dart` | 25 | the screen size in logical and physical pixels (`MediaQuery`) |
| `10_appbar_options.dart` | extra | more `AppBar` options: `leading`, `actions`, `backgroundColor`, `elevation`, `IconButton` |
| `11_scaffold_extras.dart` | extra | more `Scaffold` slots: `backgroundColor`, `bottomNavigationBar`, `Card`, `Padding` |
| `12_expanded.dart` | extra | `Expanded` and `flex`: sharing the free space 1 : 2 : 1 |

The three "extra" examples are not in the slides; they add options that almost every app uses.

## Tests

`test/widget_test.dart` starts each example in a test window and checks that the screen shows
what the example's "EXPECTED RESULT" comment promises. Some tests check claims of the slides,
for example that `MaterialApp` alone gives the text the warning style (red, underlined in
yellow) and that a `Scaffold` removes it. Run it with `flutter test`.
