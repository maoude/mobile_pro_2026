// WHAT YOU LEARN: map plugin, location permissions, camera updates and markers.
// HOW TO RUN: flutter run (after the API-key setup in README.md).
// EXPECTED RESULT: a Beirut map; toolbar buttons locate you and toggle sample pins.
import 'package:flutter/material.dart';
import 'map_app.dart';

void main() => runApp(const MapsApp(enableLocation: true, enableMarkers: true));
