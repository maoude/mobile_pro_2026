# Week 1 - Flutter examples

The Flutter widgets from the week 1 lecture notes (lecture 1.1). Each `lib/NN_*.dart` file
is a complete app with its own `main()`, and starts with a comment block that explains what
it teaches and what you should see on screen.

The numbers match the listing numbers of the lecture notes.

## First time

```
flutter pub get      # download the dependencies (provider)
flutter test         # run the automated checks: all tests should pass
flutter create .     # ONE time only: adds the android/ios/web/windows... folders
```

`flutter create .` is needed because this folder holds only the Dart code (no platform
folders). It does not change any of the files here.

## Run an example

```
flutter run                              # lib/main.dart  -> example 14
flutter run -t lib/15_counter_button.dart
flutter run -t lib/17_responsive_grid.dart -d chrome
```

## The examples

| File | Lecture section | What you see |
|---|---|---|
| `04_profile_card.dart` | 2.2 composition | a card with avatar, name and email; tap it for a message |
| `05_dependency_injection.dart` | 2.2 Provider | a spinner, then 3 user cards (Alice, Bob, Carol) |
| `07_future_builder.dart` | 2.3 FutureBuilder | the same list, using a repository supplied by Provider |
| `08_stream_cleanup.dart` | 2.3 streams | a counter that goes up with each tap of the + button |
| `10_late_bad_vs_good.dart` | 2.4 `late` | the text "ready" (swap in `BadExample` to see the crash) |
| `13_load_state_ui.dart` | 2.4 sealed classes | a spinner, `42` and `Error: timeout` |
| `14_widget_tree.dart` | 3.1 widget tree | the word "Hello" in the centre |
| `15_counter_button.dart` | 3.2 stateful | a button: "Count: 0", "Count: 1", ... |
| `16_lifecycle.dart` | 3.3 lifecycle | "Ticks" counting up each second, and the lifecycle state |
| `17_responsive_grid.dart` | 4.1 layout | a grid with 2 columns (narrow) or 3 columns (wide) |
| `18_theme.dart` | 4.2 theming | an app bar and button in colours from one blue seed |

Shared code:

* `lib/models/user.dart` - the `User` model (see also `../lect_01_01/03_user_model.dart`)
* `lib/data/user_repository.dart` - `ApiService`, `CacheService`, `UserRepository` and the
  fake implementations used by the demos

## Tests

`test/widget_test.dart` starts each example in a test window and checks that the screen shows
what the example's "EXPECTED RESULT" comment promises. It also contains the widget test from
the lecture notes (section 7, listing 20). Run it with `flutter test`.
