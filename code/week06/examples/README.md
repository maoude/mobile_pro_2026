# Week 6, part 2 - Interactivity and Navigation

Lecture notes: `../../../lectures/week06_interactivity_navigation.pdf`

The code of these notes is here, not in the PDF. `examples/` is a small Flutter project; each
`lib/NN_*.dart` file is a complete app with its own `main()`, and starts with a comment block that
says **what you learn**, **how to run it** and the **expected result** on screen. Example 06 is an
app written in several files (a folder).

## First time

```
cd examples
flutter pub get      # download the dependencies
flutter test         # run the automated checks: all tests should pass
flutter create .     # ONE time only: adds the android/windows... folders
```

`flutter create .` does not change any of the files here.

## Run an example

```
flutter run                                  # lib/main.dart -> the complete Stopwatch app (06)
flutter run -t lib/03_platform_alert.dart    # any other example
flutter run -t lib/06_stopwatch_app/main.dart -d chrome
```

## The examples

| File | What you see |
|---|---|
| `00_lap_list_builder.dart` | the week 5 stopwatch with `ListView.builder`, `itemExtent`, a `Scrollbar`, and a `ScrollController` that scrolls to the newest lap |
| `01_login_form.dart` | a login `Form` (runner and email, with validators); a valid form is replaced by "Hi *name*" on the same screen |
| `02_push_vs_replacement.dart` | `push` (with a back arrow) and `pushReplacement` (without), data passed through the constructor, and `pushAndRemoveUntil` to log out |
| `03_platform_alert.dart` | `AlertDialog`, `CupertinoAlertDialog`, the `PlatformAlert` class and `AlertDialog.adaptive`; a switch to pretend to be on iOS |
| `04_dialog_result.dart` | dialogs that return a value: a `SimpleDialog` to choose a distance, and a confirmation that returns `true`, `false` or `null` |
| `05_bottom_sheets.dart` | a modal bottom sheet that returns the chosen sort order, and a persistent bottom sheet that closes itself after 5 seconds |
| `06_stopwatch_app/` | the complete app in four files: login, `pushReplacement` to the stopwatch, laps, a dialog when it stops, a bottom sheet per lap, and Log out with confirmation |
| `07_named_routes.dart` | categories → filtered list → detail; `pushNamed`, route constants, `onGenerateRoute`, invalid arguments and unknown routes, enum labels, and a selection returned by `pop` |

Example 07 supplements [Flutter Routes](../../../lectures/week06_intro.pdf).
Run `flutter run -t lib/07_named_routes.dart`. Choose Food, then Burger, then
**Choose this item**: the list shows **Chosen: Burger**. Opening Salad and returning
with Back keeps that choice. Named routes are taught here for small apps and existing
code; Router-based navigation is more suitable for advanced URL and deep-link needs.
`test/navigation_test.dart` checks filtering, result delivery, cancellation and errors.

## Differences from the printed text

The apps follow the chapter, with the corrections explained in the lecture notes:

* `headlineSmall` instead of `headline5` (removed from Flutter), `ElevatedButton.styleFrom(backgroundColor: ...)`
  instead of `primary:` (removed), and `styleFrom` instead of `MaterialStateProperty.all` (deprecated).
* `if (!_formKey.currentState!.validate()) return;` instead of `if (form?.validate() ?? false) return;`,
  which logs in when the form is **invalid**.
* An anchored email pattern `^[^@\s]+@[^@\s]+\.[^@\s]+$` instead of `[^@]+@[^.]+..+`, which accepts `a@bcd`.
* `Timer?` instead of `late Timer`, so that `dispose` works even if Start was never pressed.
* `CupertinoDialogAction` instead of `CupertinoButton` for the actions of a `CupertinoAlertDialog`.
* The list scrolls to `itemHeight * laps.length - viewportDimension`, the exact end of the list.

## Tests

`test/widget_test.dart` starts each example in a test window, types and taps like a user, and checks
what the screen shows. Some tests check claims of the lecture notes: that `ListView.builder` does not
build the rows that are off screen, that the printed `validate() ?? false` test logs in with an
invalid form, that the printed email pattern accepts `a@bcd`, that a tap outside closes a Material
dialog but not a Cupertino one, and that `Scaffold.of` fails with the context of the widget that
creates the `Scaffold`. Run it with `flutter test`.
