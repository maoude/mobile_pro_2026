// =====================================================================
// Week 5 - Going further (not in the slides): TextEditingController
// =====================================================================
// WHAT YOU LEARN
//   * onChanged tells you about the text when the USER changes it. Sometimes
//     the program must read the text at any moment, or change it: to clear a
//     field after "Send", to fill it with a default value, to change its case.
//     For this we give the TextField a TextEditingController:
//         final _controller = TextEditingController(text: 'Flutter');
//         TextField(controller: _controller)
//   * The controller holds the text of the field:
//         _controller.text            read the text
//         _controller.text = 'abc'    change the text
//         _controller.clear()         empty the field
//   * When the PROGRAM changes the text, onChanged is NOT called. Our
//     "Characters" line must then be refreshed by calling setState ourselves.
//   * A controller must be released when the widget goes away: we create it as
//     a field of the State class and call _controller.dispose() in the
//     dispose method of the State. (initState and dispose are the beginning
//     and the end of the life of a State object.)
//
// HOW TO RUN
//   flutter run -t lib/06_text_controller.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A text field that already contains "Flutter", the line "Characters: 7"
//   and two buttons, UPPERCASE and CLEAR.
//     * Type more letters: the count follows.
//     * UPPERCASE changes the text of the field to "FLUTTER".
//     * CLEAR empties the field and the count becomes "Characters: 0".
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ControllerDemo(),
    );
  }
}

class ControllerDemo extends StatefulWidget {
  const ControllerDemo({super.key});

  @override
  State<ControllerDemo> createState() => _ControllerDemoState();
}

class _ControllerDemoState extends State<ControllerDemo> {
  // The controller holds the text of the field.
  final TextEditingController _controller =
      TextEditingController(text: 'Flutter');

  @override
  void dispose() {
    _controller.dispose(); // release the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text',
                ),
                // The user typed: redraw the count.
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Characters: ${_controller.text.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // The field redraws itself; the count does not change.
                    _controller.text = _controller.text.toUpperCase();
                  },
                  child: const Text('UPPERCASE'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    _controller.clear();
                    // onChanged is not called: refresh the count ourselves.
                    setState(() {});
                  },
                  child: const Text('CLEAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
