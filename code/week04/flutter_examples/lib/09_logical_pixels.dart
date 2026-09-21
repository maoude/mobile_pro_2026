// =====================================================================
// Week 4 - Slide 25: Logical pixels
// =====================================================================
// WHAT YOU LEARN
//   * All sizes in Flutter (SizedBox(height: 16.0), fontSize: 24, padding...)
//     are in LOGICAL pixels, not physical pixels.
//   * A logical pixel may be several physical pixels, depending on the
//     screen. The ratio is the "device pixel ratio". On a screen with ratio 2,
//     16 logical pixels are 32 physical pixels; on a ratio 3 screen, 48.
//   * So a widget keeps about the same physical size (in cm) on screens of
//     different resolutions.
//   * MediaQuery tells the app the size of the screen and the ratio.
//
// HOW TO RUN
//   flutter run -t lib/09_logical_pixels.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A page listing four facts about YOUR screen, for example on a phone
//   with ratio 2.0 and a 800 x 1600 physical screen:
//       Logical size: 400.0 x 800.0
//       Device pixel ratio: 2.0
//       Physical size: 800.0 x 1600.0
//       16 logical pixels = 32.0 physical pixels
//   (the numbers depend on the device).
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const LogicalPixelsApp());

class LogicalPixelsApp extends StatelessWidget {
  const LogicalPixelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Logical pixels')),
        body: const Center(child: ScreenFacts()),
      ),
    );
  }
}

class ScreenFacts extends StatelessWidget {
  const ScreenFacts({super.key});

  @override
  Widget build(BuildContext context) {
    // Size of the screen (or window) in LOGICAL pixels.
    final size = MediaQuery.sizeOf(context);
    // How many physical pixels one logical pixel is.
    final ratio = MediaQuery.devicePixelRatioOf(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Logical size: ${size.width} x ${size.height}'),
        Text('Device pixel ratio: $ratio'),
        Text('Physical size: ${size.width * ratio} x ${size.height * ratio}'),
        // The 16 of SizedBox(height: 16.0) is also logical pixels.
        Text('16 logical pixels = ${16 * ratio} physical pixels'),
      ],
    );
  }
}
