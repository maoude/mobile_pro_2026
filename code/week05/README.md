
# Week 5 - Creating Interactive Applications

Lecture notes: `../../lectures/week05_intro.pdf`

`flutter_examples/` is a small Flutter project. Each `lib/NN_*.dart` file is a complete app with its
own `main()`, and starts with a comment block that says **what you learn**, **how to run it** and
the **expected result** on screen. Example 05 is an app written in several files (a folder).

Parts 2 and 3 of the week have their own project, `examples/`:

* Part 2, `../../lectures/week05_gestures_state.pdf` (gestures and state): pointer events, tap, drag,
  pan, pinch and the gesture arena; ephemeral state, lifting state up, `ChangeNotifier` and the
  `provider` package.
* Part 3, `../../lectures/week05_forms_validation.pdf` (forms and validation): `DropdownButton`,
  `Form`, `GlobalKey<FormState>`, `TextFormField` and `validator`, composing validators,
  `inputFormatters`, controller listeners, `Form.of(context)`, and writing a custom `FormField`.

See `examples/README.md` (`cd examples`, then `flutter pub get`, `flutter test`,
`flutter run -t lib/01_tap_gestures.dart`).

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
flutter run                                  # lib/main.dart -> the sum app (05)
flutter run -t lib/03_you_typed.dart         # any other step
flutter run -t lib/05_sum_app/main.dart -d chrome
```

## The examples

| File | Slides | What you see |
|---|---|---|
| `00_stateful_counter.dart` | 2 to 4 | the two classes of a stateful widget; a counter that changes with `setState` |
| `01_setstate_needed.dart` | 3 | two buttons: one changes a variable with `setState`, one without; only the first updates the screen |
| `02_textfield_events.dart` | 5 | `TextField` with `style`, `decoration` (`border`, `hintText`, `labelText`, `prefixIcon`), `onChanged` and `onSubmitted` |
| `03_you_typed.dart` | 6 to 12 | the first application: the text typed in a `TextField` appears in a `Text` |
| `04_custom_textfield.dart` | 13, 14 | your own `MyTextField` widget and a callback function |
| `05_sum_app/` | 7, 8, 15 to 18 | the sum app in three files (`main.dart`, `home.dart`, `my_text_field.dart`): two `TextField`, an `ElevatedButton`, the sum in a `Text` |
| `06_text_controller.dart` | extra | `TextEditingController`: read, change and clear the text; `initState` and `dispose` |
| `07_button_styles.dart` | 18 | `ElevatedButton` fields, the round-button exercise, a disabled button |
| `08_safe_number_input.dart` | extra | `double.tryParse`, `keyboardType`, `errorText`, a button that is disabled until the input is valid |
| `09_lifecycle_log.dart` | extra | the life cycle of a `State` object: `initState`, `didChangeDependencies`, `didUpdateWidget`, `build`, `reassemble`, `deactivate`, `dispose`, logged on screen |
| `10_stopwatch_timer.dart` | Stopwatch, step 1 | a counter that goes up once a second by itself, with a `Timer.periodic` started in `initState` and cancelled in `dispose` |
| `11_stopwatch_buttons.dart` | Stopwatch, step 2 | Start and Stop buttons (`ElevatedButton`, `TextButton`) that control the `Timer`; `onPressed: null` disables a button |
| `12_stopwatch_laps.dart` | Stopwatch, step 3 | a Lap button and a scrolling `ListView` of laps, in an `Expanded`, below a counter panel |
| `13_scrolling.dart` | extra | `ListView.builder` for a 1000-item list, and a choice of `ScrollPhysics` (bouncing, clamping, never) |

The "extra" examples (06, 08, 09, 13) are not in the slides; they add what almost every app needs.
Examples 10 to 12 build one app, the **Stopwatch**, step by step.

## Differences from the slides

The apps follow the slides, with a few deliberate improvements (explained in the lecture notes):

* `super.key` instead of `Key? key` + `super(key: key)` (same meaning, shorter).
* `ValueChanged<String>` instead of `Function(String)` for the callback, and `final` fields.
* `double.tryParse` and a `double?` instead of `double.parse` and the value `-1` for "empty": the
  app no longer stops on a text that is not a number, and the number -1 can be used.
* A numeric keyboard for the number fields (`keyboardType`).

## Tests

`test/widget_test.dart` starts each example in a test window, types in the text fields and taps the
buttons like a user, and checks what the screen shows. Some tests check claims of the lecture
notes, for example that changing a variable without `setState` does not change the screen, that the
life cycle methods run in a fixed order, that a `Timer` is cancelled by `dispose`, and that
`double.parse('abc')` stops with a `FormatException`. Run it with `flutter test`.
