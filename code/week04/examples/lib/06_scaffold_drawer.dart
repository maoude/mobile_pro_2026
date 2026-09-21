// =====================================================================
// Week 4, part 3 - Recipe: a Scaffold with an AppBar and a slide-out Drawer
// =====================================================================
// WHAT YOU LEARN
//   * The Scaffold gives a screen its basic structure. Two more slots:
//       drawer      a panel that slides in from the LEFT
//       endDrawer   a panel that slides in from the RIGHT
//     Their value is a Drawer widget.
//   * When a Scaffold has a drawer, the AppBar adds the "menu" button
//     (three lines) by itself: you do not write it. With an endDrawer it also
//     adds a button at the right end. The user can also pull the drawer out
//     with a swipe from the edge of the screen.
//   * A Drawer usually holds a ListView with a DrawerHeader and some
//     ListTile rows. A ListTile has leading, title, subtitle, trailing and
//     onTap, the function that runs when the row is tapped.
//   * The drawer does not close by itself when a row is tapped: call
//     Navigator.pop(context) (the drawer is a temporary layer on top of the
//     page, and pop removes it).
//   * The page is stateful, because it remembers which row was chosen.
//
// HOW TO RUN
//   flutter run -t lib/06_scaffold_drawer.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar "Drawer Example" with a menu button on the left and a second
//   button on the right. In the middle:  Page: Home.
//   The left button (or a swipe from the left edge) slides in a drawer with a
//   teal header  Menu  and three rows: Home, Settings, About. Tapping a row
//   closes the drawer and the middle text becomes  Page: Settings  (or
//   Page: About). The right button opens a second drawer from the right.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawerPage(),
    );
  }
}

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String _page = 'Home';

  void _open(String page) {
    setState(() {
      _page = page;
    });
    Navigator.pop(context); // close the drawer
  }

  Widget _row(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: _page == label,
      onTap: () => _open(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drawer Example')),
      body: Center(
        child: Text('Page: $_page', style: const TextStyle(fontSize: 24)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _row(Icons.home, 'Home'),
            _row(Icons.settings, 'Settings'),
            _row(Icons.info, 'About'),
          ],
        ),
      ),
      endDrawer: const Drawer(
        child: Center(child: Text('End drawer')),
      ),
    );
  }
}
