# Week 6 - Flutter Routes, Interactivity and Navigation

Lecture notes: [Flutter Routes](../../lectures/week06_intro.pdf).

[flutter_examples](flutter_examples) contains the supplied restaurant menu app.
It practices `ListView.builder`, checkboxes, `setState`, network images and
`IconButton` actions in an `AppBar`. The selected-items view replaces the body
of the same screen; this example does not push a separate route.

See the [project README](flutter_examples/README.md) for setup and running instructions.

## Part 2 - Interactivity and Navigation

Lecture notes: [Interactivity and Navigation](../../lectures/week06_interactivity_navigation.pdf).

[examples](examples) is a second small Flutter project with 7 runnable apps: `ListView.builder`
with a `ScrollController`, a login form, `push` / `pushReplacement` / `pushAndRemoveUntil`,
Material, Cupertino and platform-aware dialogs, dialogs that return a value, modal and persistent
bottom sheets, and the complete Stopwatch app in four files. Automated tests check every example.

See the [project README](examples/README.md) (`cd examples`, then `flutter pub get`, `flutter test`,
`flutter run`).
