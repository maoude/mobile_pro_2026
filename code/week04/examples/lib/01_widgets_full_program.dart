// =====================================================================
// Week 4, part 3 - Widgets, their types and their parameters (full program)
// =====================================================================
// WHAT YOU LEARN
//   * This is the complete program of the lecture notes
//     week04_widgets_parameters.pdf. It puts the widget types of part 2 and
//     their common parameters together in one page:
//       VISIBLE widgets:  Text, ElevatedButton / TextButton / OutlinedButton,
//                         Image, Icon
//       LAYOUT widgets:   Row, Column, Center, Padding, Stack, Scaffold
//       PARAMETERS:       textAlign, style, padding, color, width, height,
//                         onPressed, alignment, children, mainAxisAlignment,
//                         crossAxisAlignment
//   * The page is stateful, because it remembers which button was tapped last.
//
// HOW TO RUN
//   flutter run -t lib/01_widgets_full_program.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A scrollable page with a teal AppBar "Widgets and Their Types".
//   Part 1, "Visible Widgets": the text Hello, Flutter!, three buttons
//   (Elevated, Text, Outlined), the logo image, a red heart icon and the line
//   "No button selected". Tapping a button changes that line to the name of
//   the button (ElevatedButton, TextButton or OutlinedButton).
//   Part 2, "Invisible / Layout Widgets": a Row of three labels, a Column of
//   three lines on an amber background, an orange centered box and a Stack
//   (a yellow square on a bigger blue square, with the word Stack on top).
//   Part 3, "Common Widget Parameters": a list of the parameters and a card
//   with three examples of code.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const WidgetsFullProgramApp());

class WidgetsFullProgramApp extends StatelessWidget {
  const WidgetsFullProgramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Widgets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _lastButton = 'No button selected';

  void _selectButton(String value) {
    setState(() {
      _lastButton = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets and Their Types'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flutter Widgets',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Everything in Flutter is a widget. Widgets are nested inside each other to build the user interface.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Visible widgets section
            const Text(
              '1) Visible Widgets',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Hello, Flutter!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectButton('ElevatedButton'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Elevated'),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () => _selectButton('TextButton'),
                        child: const Text('Text'),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () => _selectButton('OutlinedButton'),
                        child: const Text('Outlined'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Image.asset(
                    'assets/logo.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _lastButton,
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Invisible widgets section
            const Text(
              '2) Invisible / Layout Widgets',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const Text(
              'Row: child widgets are arranged horizontally',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Row 1'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Row 2'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Row 3'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Column: child widgets are arranged vertically',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.amber[100],
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Column item 1'),
                  SizedBox(height: 8),
                  Text('Column item 2'),
                  SizedBox(height: 8),
                  Text('Column item 3'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Center: centers child widget',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 180,
                height: 60,
                color: Colors.orange,
                child: const Center(
                  child: Text(
                    'Centered box',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Stack: widgets are drawn on top of each other',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    color: Colors.yellow,
                  ),
                  const Text(
                    'Stack',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              '3) Common Widget Parameters',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Examples of parameters used in widgets:\n'
              '• textAlign: alignment of Text\n'
              '• style: custom font, weight, color, size\n'
              '• onPressed: action when a button is tapped\n'
              '• padding: space around a widget\n'
              '• color: background or foreground color\n'
              '• width and height: size limits\n'
              '• mainAxisAlignment: arrangement along the main axis\n'
              '• crossAxisAlignment: arrangement along the cross axis\n'
              '• elevation: depth/shadow of a button\n'
              '• alignment: position inside a parent widget',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 24),

            Card(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Example parameter usage',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Text(\'Hello\', textAlign: TextAlign.center, style: TextStyle(...))'),
                    SizedBox(height: 6),
                    Text(
                        'ElevatedButton(onPressed: () {...}, child: Text(\'Click\'))'),
                    SizedBox(height: 6),
                    Text(
                        'Padding(padding: EdgeInsets.all(10), child: Text(\'Box\'))'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
