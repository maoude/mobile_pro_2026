// =====================================================================
// Week 5, part 2 - State: a ChangeNotifier model (no package needed)
// =====================================================================
// WHAT YOU LEARN
//   * To share state without passing it through every widget, we put the state
//     in a separate MODEL class that any widget can listen to. In Flutter the
//     basic tool is ChangeNotifier (it is part of Flutter itself).
//   * A model class "with ChangeNotifier":
//       * keeps the data in private fields (_value);
//       * changes it in methods (increment, decrement);
//       * calls notifyListeners() after every change. This tells everybody who
//         listens: "I changed, redraw yourselves".
//       notifyListeners() is the only thing a ChangeNotifier model must call.
//   * A widget listens with ListenableBuilder(listenable: model, builder: ...).
//     Its builder function is called again each time the model notifies, and
//     ONLY that builder is rebuilt: not the whole page. (The provider package
//     of example 09 does the same job with a Consumer.)
//   * The page has no setState at all. Buttons just call model.increment().
//   * The model is created once, in initState, and released in dispose (like a
//     TextEditingController). The two counters at the bottom of the screen
//     prove that the page is built only once, while the text is rebuilt after
//     every change. (Counting builds inside build() is only for teaching: a
//     real build method must have no side effects.)
//
// HOW TO RUN
//   flutter run -t lib/08_change_notifier.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   The text "Counter: 0" with two buttons, "-" and "+", and two lines:
//   "Page built: 1 time(s)" and "Text built: 1 time(s)". Press "+" three times:
//   the counter shows 3 and "Text built" shows 4, but "Page built" stays 1.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// The model: the state and the ways to change it.
class CounterModel with ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    notifyListeners(); // tell the listeners that the data changed
  }

  void decrement() {
    _value--;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late final CounterModel _model;
  int _pageBuilds = 0; // for teaching only
  int _textBuilds = 0; // for teaching only

  @override
  void initState() {
    super.initState();
    _model = CounterModel();
  }

  @override
  void dispose() {
    _model.dispose(); // release the model
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pageBuilds++;
    return Scaffold(
      appBar: AppBar(title: const Text('ChangeNotifier'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Only this part is rebuilt when the model notifies.
            ListenableBuilder(
              listenable: _model,
              builder: (context, child) {
                _textBuilds++;
                return Column(
                  children: [
                    Text('Counter: ${_model.value}',
                        style: const TextStyle(fontSize: 24)),
                    Text('Text built: $_textBuilds time(s)'),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: _model.decrement,
                  child: const Text('-'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _model.increment,
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Page built: $_pageBuilds time(s)'),
          ],
        ),
      ),
    );
  }
}
