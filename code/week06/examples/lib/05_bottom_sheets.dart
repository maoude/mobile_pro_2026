// =====================================================================
// Week 6, part 2 - Bottom sheets: modal and persistent
// =====================================================================
// WHAT YOU LEARN
//   * A bottom sheet is a panel that slides up from the bottom of the screen.
//     There are two kinds:
//       MODAL       showModalBottomSheet(context: ..., builder: ...)
//                   It darkens the screen and blocks it, like a dialog. It is
//                   a route: close it with Navigator.pop(context, value), and
//                   its Future gives that value (null if the user taps the
//                   dark area or drags the sheet down).
//       PERSISTENT  Scaffold.of(context).showBottomSheet((context) => ...)
//                   It does NOT block the screen: the page above it still
//                   works. It belongs to the Scaffold, and returns a
//                   PersistentBottomSheetController: controller.close()
//                   closes it, controller.closed completes when it is gone.
//   * Scaffold.of(context) looks UP the tree from context for a Scaffold. The
//     context of the build method that CREATES the Scaffold is above it, so
//     Scaffold.of fails there with "Scaffold.of() called with a context that
//     does not contain a Scaffold". The fix is the one of Form.of in week 5,
//     part 3: a Builder, whose builder receives a context BELOW the Scaffold.
//   * The persistent sheet closes itself after 5 seconds with a Timer. The
//     Timer is cancelled in dispose, like every Timer.
//
// HOW TO RUN
//   flutter run -t lib/05_bottom_sheets.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A list of five laps "Lap 1 ... 61.2 s" in their order, "Order: in order",
//   and two buttons at the bottom, SORT and SUMMARY.
//     * SORT: a modal sheet with "In order", "Fastest first", "Slowest first"
//       slides up and the screen behind goes dark. Pick "Fastest first": the
//       sheet closes and the list is sorted, fastest lap on top. Tap the dark
//       area instead: the sheet closes and nothing changes.
//     * SUMMARY: a sheet "Run completed - 5 laps, total 301.5 s" appears at
//       the bottom; the list above can still be scrolled and SORT still
//       works. It closes by itself after 5 seconds (or with its X button).
// =====================================================================

import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const BottomSheetApp());

class BottomSheetApp extends StatelessWidget {
  const BottomSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomSheetScreen(),
    );
  }
}

enum LapOrder {
  inOrder('In order'),
  fastestFirst('Fastest first'),
  slowestFirst('Slowest first');

  const LapOrder(this.label);
  final String label;
}

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({super.key});

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  // The time of each lap in milliseconds, in the order they were run.
  static const List<int> _laps = [61200, 59800, 60400, 58900, 61200];

  LapOrder _order = LapOrder.inOrder;
  PersistentBottomSheetController? _summarySheet;
  Timer? _closeTimer;

  String _seconds(int milliseconds) =>
      '${(milliseconds / 1000).toStringAsFixed(1)} s';

  // The lap numbers (1, 2, ...) in the order chosen by the user.
  List<int> get _sortedLapNumbers {
    final numbers = [for (var i = 1; i <= _laps.length; i++) i];
    switch (_order) {
      case LapOrder.inOrder:
        break;
      case LapOrder.fastestFirst:
        numbers.sort((a, b) => _laps[a - 1].compareTo(_laps[b - 1]));
      case LapOrder.slowestFirst:
        numbers.sort((a, b) => _laps[b - 1].compareTo(_laps[a - 1]));
    }
    return numbers;
  }

  // MODAL: waits for the user's choice.
  Future<void> _chooseOrder() async {
    final chosen = await showModalBottomSheet<LapOrder>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // only as tall as its content
          children: [
            for (final order in LapOrder.values)
              ListTile(
                leading: Icon(
                  order == _order ? Icons.check : null,
                ),
                title: Text(order.label),
                onTap: () => Navigator.of(context).pop(order),
              ),
          ],
        ),
      ),
    );
    if (chosen == null || !mounted) return; // closed without a choice
    setState(() => _order = chosen);
  }

  // PERSISTENT: needs a context below the Scaffold (see the Builder below).
  void _showSummary(BuildContext scaffoldContext) {
    if (_summarySheet != null) return; // already open
    final total = _laps.fold(0, (sum, lap) => sum + lap);

    final controller = Scaffold.of(scaffoldContext).showBottomSheet(
      (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Run completed - ${_laps.length} laps, '
                'total ${_seconds(total)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Close',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
    setState(() => _summarySheet = controller);

    _closeTimer = Timer(const Duration(seconds: 5), controller.close);
    controller.closed.then((_) {
      _closeTimer?.cancel();
      if (mounted) setState(() => _summarySheet = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final numbers = _sortedLapNumbers;
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom sheets')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text('Order: ${_order.label.toLowerCase()}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                final lap = numbers[index];
                return ListTile(
                  title: Text('Lap $lap'),
                  trailing: Text(_seconds(_laps[lap - 1])),
                );
              },
            ),
          ),
        ],
      ),
      // This Builder's context is BELOW the Scaffold: Scaffold.of works there.
      bottomNavigationBar: Builder(
        builder: (scaffoldContext) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _chooseOrder,
                  child: const Text('Sort'),
                ),
                ElevatedButton(
                  onPressed: _summarySheet == null
                      ? () => _showSummary(scaffoldContext)
                      : null,
                  child: const Text('Summary'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _closeTimer?.cancel();
    super.dispose();
  }
}
