// =====================================================================
// Week 5 - The ElevatedButton: its fields, its style, and a round button
// =====================================================================
// WHAT YOU LEARN
//   * ElevatedButton draws a button with a shadow: the shadow grows when you
//     press it. Its main fields:
//       child      what is inside, usually a Text (or an Icon)
//       onPressed  a function with no parameter, called when it is pressed
//       style      the look, built with ElevatedButton.styleFrom(...)
//   * onPressed: null DISABLES the button: it turns grey and does not react.
//     A button that must not be used yet (a form that is not complete) gets
//     null; the button is enabled again when the condition becomes true.
//   * The exercise of the slides, a round button:
//       shape: const StadiumBorder()          rounded ends ("pill")
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
//                                             rounded corners
//       shape: const CircleBorder()           a circle (give it an Icon)
//   * More options of styleFrom: backgroundColor, foregroundColor (the color
//     of the label), elevation (the shadow), padding, minimumSize.
//   * The page is stateful: it remembers the last button pressed, and whether
//     the last button is enabled (a Switch controls it).
//
// HOW TO RUN
//   flutter run -t lib/07_button_styles.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The line "Last pressed: none", then five buttons: DEFAULT (normal), PILL
//   (deep purple, rounded ends), ROUNDED (green, rounded corners), a red
//   circle with a heart icon, and a last button DISABLED, which is grey until
//   you turn on the switch "Enable the last button". Every enabled button
//   changes the first line to its own name.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ButtonStyles(),
    );
  }
}

class ButtonStyles extends StatefulWidget {
  const ButtonStyles({super.key});

  @override
  State<ButtonStyles> createState() => _ButtonStylesState();
}

class _ButtonStylesState extends State<ButtonStyles> {
  String _last = 'none';
  bool _lastEnabled = false;

  void _press(String name) {
    setState(() {
      _last = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Last pressed: $_last', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            // The default look.
            ElevatedButton(
              onPressed: () => _press('DEFAULT'),
              child: const Text('DEFAULT'),
            ),
            const SizedBox(height: 12),

            // Rounded ends.
            ElevatedButton(
              onPressed: () => _press('PILL'),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text('PILL'),
            ),
            const SizedBox(height: 12),

            // Rounded corners.
            ElevatedButton(
              onPressed: () => _press('ROUNDED'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                elevation: 8,
              ),
              child: const Text('ROUNDED'),
            ),
            const SizedBox(height: 12),

            // A circle.
            ElevatedButton(
              onPressed: () => _press('HEART'),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Icon(Icons.favorite),
            ),
            const SizedBox(height: 12),

            // onPressed: null disables the button.
            ElevatedButton(
              onPressed: _lastEnabled ? () => _press('DISABLED') : null,
              child: const Text('DISABLED'),
            ),
            SwitchListTile(
              title: const Text('Enable the last button'),
              value: _lastEnabled,
              onChanged: (value) {
                setState(() {
                  _lastEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
