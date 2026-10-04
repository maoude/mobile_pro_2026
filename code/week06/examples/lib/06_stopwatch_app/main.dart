// =====================================================================
// Week 6, part 2 - The complete Stopwatch app (several files)
// =====================================================================
// WHAT YOU LEARN
//   * The whole chapter in one app, written in four files:
//       main.dart            the root: a MaterialApp whose home is the login
//       login_screen.dart    a Form; when it is valid, pushReplacement opens
//                            the stopwatch and passes the name and email
//       stopwatch.dart       the stopwatch with laps (ListView.builder,
//                            ScrollController), a dialog when it stops, a
//                            bottom sheet for one lap, and Log out
//       platform_alert.dart  the platform-aware dialog of example 03
//   * Each screen imports only what it uses. login_screen.dart imports
//     stopwatch.dart (to open it) and stopwatch.dart imports
//     login_screen.dart (to come back on Log out): two files may import
//     each other in Dart.
//
// HOW TO RUN
//   flutter run                                (lib/main.dart starts this app)
//   flutter run -t lib/06_stopwatch_app/main.dart
//   (see ../../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   1. "Login": fill "Runner" (Lina) and "Email" (lina@mail.com), press
//      CONTINUE. The stopwatch opens with "Lina" in the app bar and NO back
//      arrow: the login screen was replaced.
//   2. START, then LAP a few times: the laps fill the list, which scrolls to
//      the newest one.
//   3. STOP: a dialog "Run completed!" gives the total time of all the laps
//      plus the current one. CLOSE it.
//   4. Tap a lap in the list: a bottom sheet shows its time, how much slower
//      it was than the fastest lap (or "Fastest lap"), and a CLOSE button.
//   5. The Log out icon in the app bar asks "Log out?"; LOG OUT returns to an
//      empty login screen, CANCEL keeps the stopwatch.
// =====================================================================

import 'package:flutter/material.dart';

import 'login_screen.dart';

void main() => runApp(const StopWatchApp());

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stopwatch',
      home: LoginScreen(),
    );
  }
}
