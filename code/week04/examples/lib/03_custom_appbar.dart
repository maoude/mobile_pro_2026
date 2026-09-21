// =====================================================================
// Week 4, part 3 - Recipe: an AppBar in a class of its own
// =====================================================================
// WHAT YOU LEARN
//   * The appBar slot of a Scaffold needs to know the HEIGHT of the bar
//     before it draws it. A widget that goes there must implement
//     PreferredSizeWidget and give its height in "preferredSize".
//     AppBar already does; your own widget must do it too.
//   * So a custom class MyAppBar extends StatelessWidget and implements
//     PreferredSizeWidget. Its build method returns a normal AppBar.
//     Use the SAME number for preferredSize and for AppBar.toolbarHeight,
//     so that the title is centered in the bar you announced.
//   * The main AppBar fields: title, backgroundColor, elevation (0 = flat,
//     more than 0 = raised with a shadow), leading (the left end, for a
//     menu icon) and actions (the right end, a list of widgets).
//   * If you give the bar a dark backgroundColor, also give foregroundColor:
//     otherwise the title and the icons may be dark on dark and invisible.
//
// HOW TO RUN
//   flutter run -t lib/03_custom_appbar.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A flat black app bar, 100 pixels tall, with a white menu icon on the
//   left, the white title  Container Widget  and a white settings icon on the
//   right. Below it, the centered text  Hello Flutter!. Tapping the menu or
//   the settings icon shows the message  Menu tapped  or  Settings tapped
//   at the bottom of the screen.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = 'Container Widget';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: MyAppBar(title: title),
        body: MyCenterWidget(),
      ),
    );
  }
}

// The app bar, in its own class. "implements PreferredSizeWidget" is what
// allows it to be used as the appBar of a Scaffold.
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});

  final String title;

  static const double height = 100;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      toolbarHeight: height,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () => _say(context, 'Menu tapped'),
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () => _say(context, 'Settings tapped'),
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  void _say(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Hello Flutter!'),
    );
  }
}
