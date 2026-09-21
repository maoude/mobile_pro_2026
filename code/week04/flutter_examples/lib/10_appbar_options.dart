// =====================================================================
// Week 4 - Going further (not in the slides): more AppBar options
// =====================================================================
// WHAT YOU LEARN
//   * AppBar has more fields than "title" and "centerTitle":
//       leading           a widget at the LEFT end (often a menu icon)
//       actions           a list of widgets at the RIGHT end (icon buttons)
//       backgroundColor   the color of the bar
//       foregroundColor   the color of the title and of the icons
//       elevation         the height of the shadow under the bar:
//                         0 = flat, a bigger number = a stronger shadow
//   * IconButton(icon: ..., onPressed: ...) is a tappable icon.
//     onPressed is a function: it runs when the user taps (week 2).
//   * ScaffoldMessenger.of(context).showSnackBar(...) shows a short message
//     at the bottom of the screen.
//
// HOW TO RUN
//   flutter run -t lib/10_appbar_options.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A teal app bar with white text and icons, and a shadow under it:
//     * a menu icon on the left
//     * the title  AppBar options
//     * a search icon and a settings icon on the right
//   The middle of the page says  Tap the icons in the app bar.
//   Tapping an icon shows a message at the bottom: Menu tapped,
//   Search tapped or Settings tapped.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AppBarOptionsPage());
  }
}

//#region notes
class AppBarOptionsPage extends StatelessWidget {
  const AppBarOptionsPage({super.key});

  // Shows a short message at the bottom of the screen.
  void _say(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar options'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white, // color of the title and the icons
        elevation: 4, // a shadow under the bar (0 would be flat)
        // leading: a widget at the left end of the bar
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _say(context, 'Menu tapped'),
        ),
        // actions: widgets at the right end, in a list
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _say(context, 'Search tapped'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _say(context, 'Settings tapped'),
          ),
        ],
      ),
      body: const Center(child: Text('Tap the icons in the app bar')),
    );
  }
}

//#endregion notes
