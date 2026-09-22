// =====================================================================
// Week 5, part 3 - Listening to a controller: addListener vs onChanged
// =====================================================================
// WHAT YOU LEARN
//   * Week 5, part 1 (example 06_text_controller) showed that when the
//     PROGRAM changes a field's text (controller.text = '...'), onChanged is
//     NOT called: only the user's own typing triggers it.
//   * TextEditingController is a ValueNotifier: setting .text calls
//     notifyListeners() whichever way the text changed, by the user or by the
//     program. So a listener added with controller.addListener(...) fires in
//     BOTH cases. Use addListener when you need to react to every change of
//     the text, no matter where it comes from; use onChanged when you only
//     care about what the user typed (as in most of week 5, part 1).
//   * addListener takes a function with NO parameters: read the new value
//     from the controller itself, controller.text, inside that function.
//   * Like any resource you set up, remove the listener and dispose the
//     controller in dispose (week 5, part 1): forgetting removeListener leaks
//     the callback; forgetting dispose leaks the controller.
//
// HOW TO RUN
//   flutter run -t lib/14_controller_listener.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A field, the line "Mirrored by addListener: " and a button "SET TO HELLO
//   (programmatically)".
//     * Type "Hi": the mirrored line follows every letter, exactly like
//       onChanged would.
//     * Press the button: the field shows "Hello", set by the PROGRAM, and the
//       mirrored line ALSO updates to "Hello" - addListener saw it, which an
//       onChanged callback would not have.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ControllerListenerPage(),
    );
  }
}

class ControllerListenerPage extends StatefulWidget {
  const ControllerListenerPage({super.key});

  @override
  State<ControllerListenerPage> createState() =>
      _ControllerListenerPageState();
}

class _ControllerListenerPageState extends State<ControllerListenerPage> {
  final _controller = TextEditingController();
  String _mirrored = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChanged);
  }

  // No parameter: the new text is read from the controller itself.
  void _onControllerChanged() {
    setState(() {
      _mirrored = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller listener')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 260,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 16),
            Text('Mirrored by addListener: $_mirrored',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // A programmatic change: onChanged would stay silent, but the
                // listener above still fires.
                _controller.text = 'Hello';
              },
              child: const Text('SET TO HELLO (programmatically)'),
            ),
          ],
        ),
      ),
    );
  }
}
