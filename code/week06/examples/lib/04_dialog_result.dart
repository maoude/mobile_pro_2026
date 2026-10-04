// =====================================================================
// Week 6, part 2 - Dialogs that return a value
// =====================================================================
// WHAT YOU LEARN
//   * showDialog<T> returns a Future<T?>. The value is the one given to
//     Navigator.pop when the dialog is closed:
//         Navigator.of(context).pop(true);   // the dialog's Future gives true
//     So the code that opened the dialog can WAIT for the answer:
//         final ok = await showDialog<bool>(...);
//   * The answer can be null: the user can close a Material dialog by tapping
//     outside it (or with the Back button), and then nobody called pop with a
//     value. Test "ok == true", not just "ok".
//   * After an await, the screen may have been closed in the meantime. Before
//     using context or setState again, check that the State is still there:
//         if (!mounted) return;
//     (In a StatelessWidget, or with a context that you received as a
//     parameter, the check is: if (!context.mounted) return;)
//   * A SimpleDialog shows a list of choices. Each SimpleDialogOption pops the
//     dialog with its own value: here a distance in metres.
//   * The same idea works with routes: await Navigator.push(...) gives the
//     value that the pushed screen passes to pop.
//
// HOW TO RUN
//   flutter run -t lib/04_dialog_result.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   "Distance: 400 m", "Laps: 3", and the buttons CHOOSE DISTANCE and
//   CLEAR LAPS.
//     * CHOOSE DISTANCE: a list "100 m", "200 m", "400 m", "800 m"; pick
//       "800 m" and the first line becomes "Distance: 800 m". Tap outside
//       the list instead: nothing changes.
//     * CLEAR LAPS: "Clear all laps?" with CANCEL and CLEAR. CANCEL (or a tap
//       outside) keeps "Laps: 3"; CLEAR changes it to "Laps: 0".
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const DialogResultApp());

class DialogResultApp extends StatelessWidget {
  const DialogResultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DialogResultScreen(),
    );
  }
}

class DialogResultScreen extends StatefulWidget {
  const DialogResultScreen({super.key});

  @override
  State<DialogResultScreen> createState() => _DialogResultScreenState();
}

class _DialogResultScreenState extends State<DialogResultScreen> {
  int _distance = 400;
  final List<int> _laps = [61200, 59800, 60400];

  Future<void> _chooseDistance() async {
    final chosen = await showDialog<int>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Distance of one lap'),
        children: [
          for (final metres in [100, 200, 400, 800])
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(metres),
              child: Text('$metres m'),
            ),
        ],
      ),
    );
    if (chosen == null || !mounted) return; // closed without a choice
    setState(() => _distance = chosen);
  }

  Future<void> _clearLaps() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all laps?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return; // false, or null (tap outside)
    setState(() => _laps.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Distance: $_distance m'),
            Text('Laps: ${_laps.length}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _chooseDistance,
              child: const Text('Choose distance'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _clearLaps,
              child: const Text('Clear laps'),
            ),
          ],
        ),
      ),
    );
  }
}
