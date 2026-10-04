// =====================================================================
// Week 6, part 2 - Dialogs: Material, Cupertino, and platform-aware
// =====================================================================
// WHAT YOU LEARN
//   * A dialog is shown by a FUNCTION, not by putting a widget in the tree:
//         showDialog(context: context, builder: (context) => AlertDialog(...))
//     Like MaterialPageRoute, it takes a builder. A dialog IS a route: it is
//     pushed on the Navigator's stack, and closed with Navigator.pop.
//   * AlertDialog (Material, Android look) has a title, a content and a list
//     of actions (usually TextButtons). The iOS version is shown with
//     showCupertinoDialog and a CupertinoAlertDialog, whose actions are
//     CupertinoDialogActions.
//   * A small class, PlatformAlert, hides the choice: its show method reads
//     Theme.of(context).platform and shows the dialog of the right family.
//     The rest of the app only writes:
//         PlatformAlert(title: '...', message: '...').show(context);
//   * Flutter also has this built in: AlertDialog.adaptive(...) is an
//     AlertDialog on Android and a CupertinoAlertDialog on iOS and macOS;
//     use TextButton for its actions in both cases.
//   * Differences to know: a Material dialog closes when you tap outside it
//     (barrierDismissible: true by default); a Cupertino dialog does not, the
//     user must press one of its buttons.
//   * To SEE the iOS dialogs on Windows, Android or the web, the switch at the
//     top changes the platform of the app's theme (ThemeData.platform).
//
// HOW TO RUN
//   flutter run -t lib/03_platform_alert.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A switch "Pretend to be iOS" (off) and four buttons.
//     * MATERIAL DIALOG: a dialog "Run completed!" with a CLOSE button.
//     * CUPERTINO DIALOG: the iOS dialog, centred text, a "Close" action.
//     * PLATFORM ALERT and ADAPTIVE DIALOG: the Material dialog while the
//       switch is off; turn the switch on and they show the iOS dialog.
//   Close any dialog and the text "Dialogs closed: n" goes up by one.
// =====================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AlertApp());

// --- The class from the lecture ----------------------------------------

class PlatformAlert {
  const PlatformAlert({required this.title, required this.message});

  final String title;
  final String message;

  // Future: it completes when the dialog is closed (see example 04).
  Future<void> show(BuildContext context) {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return _showCupertinoAlert(context);
    }
    return _showMaterialAlert(context);
  }

  Future<void> _showMaterialAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCupertinoAlert(BuildContext context) {
    return showCupertinoDialog<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// --- The demo app -------------------------------------------------------

class AlertApp extends StatefulWidget {
  const AlertApp({super.key});

  @override
  State<AlertApp> createState() => _AlertAppState();
}

class _AlertAppState extends State<AlertApp> {
  bool _pretendIOS = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // null = the real platform of the device.
      theme: ThemeData(platform: _pretendIOS ? TargetPlatform.iOS : null),
      home: AlertDemo(
        pretendIOS: _pretendIOS,
        onPretendIOSChanged: (value) => setState(() => _pretendIOS = value),
      ),
    );
  }
}

class AlertDemo extends StatefulWidget {
  const AlertDemo({
    super.key,
    required this.pretendIOS,
    required this.onPretendIOSChanged,
  });

  final bool pretendIOS;
  final ValueChanged<bool> onPretendIOSChanged;

  @override
  State<AlertDemo> createState() => _AlertDemoState();
}

class _AlertDemoState extends State<AlertDemo> {
  static const _title = 'Run completed!';
  static const _message = 'Total run time is 12.3 seconds.';

  int _closed = 0;

  // Every button waits for its dialog to close, then counts it.
  Future<void> _count(Future<void> dialog) async {
    await dialog;
    if (!mounted) return;
    setState(() => _closed++);
  }

  void _material() {
    _count(showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(_title),
        content: const Text(_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    ));
  }

  void _cupertino() {
    _count(showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text(_title),
        content: const Text(_message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    ));
  }

  void _platformAlert() {
    _count(const PlatformAlert(title: _title, message: _message).show(context));
  }

  void _adaptive() {
    _count(showAdaptiveDialog<void>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text(_title),
        content: const Text(_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialogs')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              title: const Text('Pretend to be iOS'),
              value: widget.pretendIOS,
              onChanged: widget.onPretendIOSChanged,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _material,
              child: const Text('Material dialog'),
            ),
            ElevatedButton(
              onPressed: _cupertino,
              child: const Text('Cupertino dialog'),
            ),
            ElevatedButton(
              onPressed: _platformAlert,
              child: const Text('Platform alert'),
            ),
            ElevatedButton(
              onPressed: _adaptive,
              child: const Text('Adaptive dialog'),
            ),
            const SizedBox(height: 20),
            Text('Dialogs closed: $_closed', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
