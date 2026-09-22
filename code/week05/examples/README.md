
# Week 5, parts 2 and 3 - Gestures, State, Forms and Validation

Lecture notes: `../../lectures/week05_gestures_state.pdf` (part 2) and
`../../lectures/week05_forms_validation.pdf` (part 3)

The code of these notes is here, not in the PDF. `examples/` is a small Flutter project; each
`lib/NN_*.dart` file is a complete app with its own `main()`, and starts with a comment block that
says **what you learn**, **how to run it** and the **expected result** on screen.

## First time

```
cd examples
flutter pub get      # download the dependencies (this includes the provider package)
flutter test         # run the automated checks: all tests should pass
flutter create .     # ONE time only: adds the android/web/windows... folders
```

`flutter create .` does not change any of the files here.

## Run an example

```
flutter run -t lib/01_tap_gestures.dart
flutter run -t lib/09_provider_cart.dart -d chrome
```

## The examples

### Gestures

| File | Notes | What you see |
|---|---|---|
| `00_pointer_events.dart` | section 2 | `Listener`: the last pointer event (down, move, up, cancel), the position, and four counters |
| `01_tap_gestures.dart` | sections 3, 4 | `GestureDetector`: `onTapDown`, `onTapUp`, `onTap`, `onTapCancel`, `onDoubleTap`, `onLongPress`; a tap is delayed while `onDoubleTap` is set |
| `02_drag_gestures.dart` | section 5 | a red square that slides along a horizontal track and a green one along a vertical track (`onHorizontalDrag*`, `onVerticalDrag*`) |
| `03_pan_ball.dart` | section 5 | a ball that you move in any direction (`onPan*`), kept inside its square with `clamp` |
| `04_pinch_scale.dart` | section 5 | pinch to zoom and rotate a square (`onScale*`); the size is kept from one pinch to the next |
| `05_gesture_arena.dart` | section 6 | nested detectors: the child wins the tap (default), or both get it with a `RawGestureDetector` |

### State

| File | Notes | What you see |
|---|---|---|
| `06_ephemeral_state.dart` | section 8 | state inside one widget: a button whose label is its state, and three hearts that each have their own |
| `07_lifting_state_up.dart` | section 9 | a cart count shown in three places: the state is in the common ancestor (data down, events up) |
| `08_change_notifier.dart` | section 10 | a `ChangeNotifier` model and a `ListenableBuilder`; no `setState`; only the text is rebuilt |
| `09_provider_cart.dart` | section 11 | the `provider` package: `MultiProvider`, `ChangeNotifierProvider`, `Consumer`, `context.read` and `select`; a catalog and a cart page share one cart, and a dark theme |

### Forms and validation (part 3)

| File | Notes | What you see |
|---|---|---|
| `10_dropdown_button.dart` | section 1 | `DropdownButton<String>`: `items` built with `.map().toList()`, `value` kept in the state, `onChanged` |
| `11_form_validation.dart` | section 2 | `Form`, `GlobalKey<FormState>`, two `TextFormField`s with `validator`, a dropdown, Submit (`validate()`) and Reset (`reset()`) |
| `12_more_validators.dart` | section 3 | small validators chained with `_combine`, a "confirm password" check, and `AutovalidateMode.onUserInteraction` |

### Going deeper into forms (part 3)

| File | Notes | What you see |
|---|---|---|
| `13_input_formatters.dart` | section 4 | `inputFormatters`: `FilteringTextInputFormatter.digitsOnly` and `LengthLimitingTextInputFormatter`, restricting a field to 6 digits |
| `14_controller_listener.dart` | section 4 | `TextEditingController.addListener`: fires for both user typing and a programmatic `controller.text = ...`, unlike `onChanged` |
| `15_form_of_builder.dart` | section 4 | `Form.of(context)` through a `Builder`, as an alternative to the `GlobalKey<FormState>` of example 11 |
| `16_custom_formfield.dart` | section 4 | a hand-written `VerificationCodeFormField extends FormField<String>`, with its own `FormFieldState` subclass and a persistent controller |

## Tests

`test/widget_test.dart` starts each example in a test window and touches it like a user: it presses,
moves and lifts pointers, taps, long-presses, drags and pinches with two fingers, and checks what
the screen shows. Some tests check claims of the notes, for example that a tap is delayed while
`onDoubleTap` is set, that the deepest `GestureDetector` wins the tap, that a `ListenableBuilder`
rebuilds only itself, and that a `Consumer` without a provider above it fails. It also checks the
forms and validation examples: that `Submit` on an empty form shows both errors and does nothing
else, that `Reset` clears the fields and the dropdown, that validators chained with `_combine`
and `AutovalidateMode.onUserInteraction` behave as the notes describe, that `addListener` (unlike
`onChanged`) fires for a programmatic text change, that `Form.of(context)` throws when `context` is
above the `Form`, and that the custom `VerificationCodeFormField` validates, saves and resets like a
built-in `TextFormField`. Run it with `flutter test`.

The other week 5 examples (`TextField`, buttons, the sum app) are in `../flutter_examples`.
