// =====================================================================
// Week 5 - The life cycle of a State object
// =====================================================================
// WHAT YOU LEARN
//   * A State object has a LIFE, and Flutter calls its methods in a fixed
//     order. In this page the child widget writes its name in a log each time
//     one of its life cycle methods is called, and the log is shown below.
//       initState               once, when the State object is created; like a
//                               constructor: start timers, create controllers.
//                               The widget is not in the tree yet.
//       didChangeDependencies   right after initState, and again when something
//                               the widget depends on changes (Theme, MediaQuery,
//                               an InheritedWidget). Here the BuildContext can
//                               be used for the first time.
//       didUpdateWidget         when the PARENT builds again and gives the
//                               widget new parameters (here, another label). The
//                               State is kept; the old widget is a parameter.
//       build                   REQUIRED; describes the interface. Called after
//                               each of the methods above and after setState.
//       reassemble              only in development, at a hot reload.
//       deactivate              the State is removed from the tree.
//       dispose                 the State is destroyed, for ever. The LAST place
//                               to release what you created in initState
//                               (Timer.cancel(), controller.dispose()).
//   * Order at the start: initState, didChangeDependencies, build.
//     Order at the end: deactivate, dispose.
//   * Forgetting dispose leaks memory: a Timer keeps ticking after its screen
//     is gone (the stopwatch examples 10 to 12 cancel theirs).
//   * The log is a ChangeNotifier (week 5, part 2). The child adds lines during
//     a build, so the notification is sent after the frame is drawn.
//
// HOW TO RUN
//   flutter run -t lib/09_lifecycle_log.dart
//   (see ../README.md the first time: run "flutter create ." once)
//   Press r (hot reload) in the terminal: "reassemble" is added to the log.
//
// EXPECTED RESULT (on screen)
//   A card "Child: A", two buttons, and a numbered log, newest line first:
//     3. build   2. didChangeDependencies   1. initState
//   Change label: the card says "Child: B", and the log gets
//     didUpdateWidget: A -> B   and   build.
//   Hide child: the card disappears, and the log gets  deactivate  and  dispose.
//   Show child: a NEW State is created: initState ... again.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LifecyclePage(),
    );
  }
}

// A list of lines that tells its listeners when a line is added.
class LogModel extends ChangeNotifier {
  final List<String> lines = [];
  bool _disposed = false;

  void add(String line) {
    lines.add(line);
    // add() is called in the middle of a build: notify after the frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_disposed) notifyListeners();
    });
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

class LifecyclePage extends StatefulWidget {
  const LifecyclePage({super.key});

  @override
  State<LifecyclePage> createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<LifecyclePage> {
  final LogModel _log = LogModel();
  bool _show = true;
  String _label = 'A';

  @override
  void dispose() {
    _log.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Life cycle'), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {
                  // New parameter: the child gets didUpdateWidget.
                  setState(() => _label = _label == 'A' ? 'B' : 'A');
                },
                child: const Text('Change label'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => _show = !_show),
                child: Text(_show ? 'Hide child' : 'Show child'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // When _show is false, the child leaves the tree: dispose.
          if (_show) LifecycleChild(label: _label, log: _log),
          const Divider(),
          Expanded(
            child: ListenableBuilder(
              listenable: _log,
              builder: (context, child) {
                // The newest line is at the top, so it is always visible.
                return ListView.builder(
                  itemCount: _log.lines.length,
                  itemBuilder: (context, i) {
                    final n = _log.lines.length - i; // the line number
                    return ListTile(
                      dense: true,
                      title: Text('$n. ${_log.lines[n - 1]}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LifecycleChild extends StatefulWidget {
  const LifecycleChild({super.key, required this.label, required this.log});

  final String label;
  final LogModel log;

  @override
  State<LifecycleChild> createState() => _LifecycleChildState();
}

class _LifecycleChildState extends State<LifecycleChild> {
  @override
  void initState() {
    super.initState();
    widget.log.add('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.log.add('didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant LifecycleChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.log.add('didUpdateWidget: ${oldWidget.label} -> ${widget.label}');
  }

  @override
  void reassemble() {
    super.reassemble();
    widget.log.add('reassemble');
  }

  @override
  Widget build(BuildContext context) {
    widget.log.add('build'); // for teaching only: build must be free of effects
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Child: ${widget.label}',
            style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  @override
  void deactivate() {
    widget.log.add('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    widget.log.add('dispose');
    super.dispose();
  }
}
