// =====================================================================
// Lecture 1.1, section 2.4: Sealed classes drive the UI
// =====================================================================
// WHAT YOU LEARN
//   * The three states of any screen that loads data are modelled as a
//     sealed class: Loading, Success(data) or Failure(message).
//   * The switch in buildUI() must cover EVERY state. Add a new state and
//     the compiler tells you every place you forgot to handle it, so there
//     are no "silent failures" leaking into the UI.
//   * (The plain-Dart version of this idea is
//      ../../lect_01_01/13_records_and_sealed_classes.dart)
//
// HOW TO RUN
//   flutter run -t lib/13_load_state_ui.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   Three rows, one per state:
//     Loading  ->  a spinning progress indicator
//     Success  ->  the text  42
//     Failure  ->  the text  Error: timeout
// =====================================================================

import 'package:flutter/material.dart';

sealed class LoadState<T> {
  const LoadState();
}

class Loading<T> extends LoadState<T> {
  const Loading();
}

class Success<T> extends LoadState<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends LoadState<T> {
  final String message;
  const Failure(this.message);
}

// One widget per state. The switch is exhaustive (all subclasses covered).
Widget buildUI<T>(LoadState<T> s) => switch (s) {
      Loading() => const CircularProgressIndicator(),
      Success(data: final d) => Text('$d'),
      Failure(message: final m) => Text('Error: $m'),
    };

// ---------------- Demo app (only used when this file is run) ----------------
void main() => runApp(const LoadStateApp());

class LoadStateApp extends StatelessWidget {
  const LoadStateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Sealed LoadState')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildUI<int>(const Loading()),
              const SizedBox(height: 24), // vertical gap
              buildUI<int>(const Success(42)),
              const SizedBox(height: 24),
              buildUI<int>(const Failure('timeout')),
            ],
          ),
        ),
      ),
    );
  }
}
