// WHAT YOU LEARN: foreground permissions, async errors and animateCamera.
// HOW TO RUN: flutter run -t lib/01_user_location.dart (requires map-key setup).
// EXPECTED RESULT: tap Find my location; camera moves or a visible error appears.
import 'package:flutter/material.dart';
import 'map_app.dart';

void main() => runApp(const MapsApp(enableLocation: true));
