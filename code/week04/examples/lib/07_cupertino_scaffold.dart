// =====================================================================
// Week 4, part 3 - Recipe: the same structure in the Cupertino (iOS) style
// =====================================================================
// WHAT YOU LEARN
//   * Flutter has two families of ready-made widgets:
//       Material    the design language of Google (Material Design)
//       Cupertino   the look of iOS (Apple's Human Interface Guidelines)
//     Both work on every platform: Flutter draws the widgets itself. You
//     choose the style, not the operating system.
//   * Each family has its own way to give a screen its structure:
//       Material    MaterialApp     Scaffold               AppBar
//       Cupertino   CupertinoApp    CupertinoPageScaffold  CupertinoNavigationBar
//     (There is no widget called CupertinoScaffold. For an iOS app with tabs
//     at the bottom, use CupertinoTabScaffold with a CupertinoTabBar.)
//   * The slots have other names: the bar is "navigationBar", its title is
//     "middle" (with "leading" and "trailing" at the ends), and the content
//     is the "child".
//   * iOS has no side drawer: the Cupertino library does not have one.
//   * CupertinoButton is the iOS button; it takes child and onPressed as
//     the Material buttons do.
//
// HOW TO RUN
//   flutter run -t lib/07_cupertino_scaffold.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A light iOS-style navigation bar with the centered title  Cupertino
//   Example  and the text  Home  on its left end. Below it, in the middle
//   of the page, the text  Taps: 0  and a blue text button  Add. Each tap
//   on the button adds 1 to the counter.
// =====================================================================

import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPage(),
    );
  }
}

class CupertinoPage extends StatefulWidget {
  const CupertinoPage({super.key});

  @override
  State<CupertinoPage> createState() => _CupertinoPageState();
}

class _CupertinoPageState extends State<CupertinoPage> {
  int _taps = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Text('Home'),
        middle: Text('Cupertino Example'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Taps: $_taps'),
              CupertinoButton(
                onPressed: () => setState(() => _taps++),
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
