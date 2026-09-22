// =====================================================================
// Week 5, part 2 - State: ephemeral (local) state
// =====================================================================
// WHAT YOU LEARN
//   * The STATE of an app is the data that can change while it runs, and the
//     screen is a picture of that state: when the state changes, the widgets
//     that depend on it are built again (Flutter is "declarative").
//   * Some state belongs to ONE widget and nobody else needs it: whether a
//     heart is filled, which tab is open, what is typed in a field, the
//     current page of a carousel. It is called EPHEMERAL state (also UI state
//     or local state). It is enough to keep it in the State class of that
//     widget and change it with setState. You do not need any special
//     state-management technique for it.
//   * Every widget object has its OWN state. Three LikeButton widgets are
//     three State objects: tapping one heart does not change the others.
//   * The state variable is private (_name, _liked): only the State class can
//     read it and only setState changes it in a way that redraws the widget.
//   * The example of NameToggle is the classic one: a button whose label is
//     the state.
//
// HOW TO RUN
//   flutter run -t lib/06_ephemeral_state.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A button "Rami" and three lines "Photo 1", "Photo 2", "Photo 3", each with
//   an empty heart. Tap the button: its label changes to "Lina", and back to
//   "Rami" on the next tap. Tap the heart of Photo 2: only that heart becomes
//   red and filled; the other two do not change. Tap it again: it is empty.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Ephemeral state'), centerTitle: true),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NameToggle(),
              SizedBox(height: 24),
              LikeButton(label: 'Photo 1'),
              LikeButton(label: 'Photo 2'),
              LikeButton(label: 'Photo 3'),
            ],
          ),
        ),
      ),
    );
  }
}

// The state is the name shown on the button.
class NameToggle extends StatefulWidget {
  const NameToggle({super.key});

  @override
  State<NameToggle> createState() => _NameToggleState();
}

class _NameToggleState extends State<NameToggle> {
  String _name = 'Rami';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _name = _name == 'Rami' ? 'Lina' : 'Rami';
        });
      },
      child: Text(_name),
    );
  }
}

// The state is a bool: is this photo liked? Each LikeButton has its own.
class LikeButton extends StatefulWidget {
  const LikeButton({super.key, required this.label});

  final String label; // the widget's configuration (it never changes)

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _liked = false; // the state (it changes)

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label), // widget.xxx reads the configuration
        IconButton(
          icon: Icon(
            _liked ? Icons.favorite : Icons.favorite_border,
            color: _liked ? Colors.red : null,
          ),
          onPressed: () {
            setState(() {
              _liked = !_liked;
            });
          },
        ),
      ],
    );
  }
}
