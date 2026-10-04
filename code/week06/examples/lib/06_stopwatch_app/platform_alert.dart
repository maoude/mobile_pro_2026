// The platform-aware dialog of example 03: an AlertDialog on Android, Windows,
// Linux and the web, a CupertinoAlertDialog on iOS and macOS.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlert {
  const PlatformAlert({required this.title, required this.message});

  final String title;
  final String message;

  // The Future completes when the dialog is closed.
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
