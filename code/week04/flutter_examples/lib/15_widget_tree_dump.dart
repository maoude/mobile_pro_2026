// =====================================================================
// Week 4, part 2 - The widget tree, printed by Flutter itself
// =====================================================================
// WHAT YOU LEARN
//   * An app is a TREE of widgets: the root is MyApp, and each widget
//     contains other widgets (its children).
//   * You can see the real tree: debugDumpApp() prints it in the console.
//     Press the round button of this app, then look at the terminal (or
//     the "Debug Console" of VS Code) where you started the app.
//   * The dump also lists widgets you never wrote (Theme, MediaQuery,
//     Navigator...). MaterialApp and Scaffold create them for you.
//   * The tree describes the app for its CURRENT state. When the state
//     changes, Flutter builds a new tree and compares it with the old one.
//
// HOW TO RUN
//   flutter run -t lib/15_widget_tree_dump.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The app bar "Widget tree", the two lines  Hello  and  World  centered,
//   and a round button with a tree icon at the bottom right.
//   Pressing the button prints the widget tree in the console. It is long,
//   because MaterialApp adds many widgets of its own. Look for, from the outside
//   in: MyApp, MaterialApp, HomePage, Scaffold. Inside the Scaffold: AppBar,
//   Center (containing Column, Text Hello, Text World) and the
//   FloatingActionButton (containing the Icon).
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

//#region notes
// The root of the tree.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

// The page: a Scaffold with an app bar, a body and a button.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget tree')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Hello'), Text('World')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Print the whole widget tree of the running app in the console.
        onPressed: () {
          debugPrint('--- widget tree of the running app ---');
          debugDumpApp();
        },
        child: const Icon(Icons.account_tree),
      ),
    );
  }
}

//#endregion notes
