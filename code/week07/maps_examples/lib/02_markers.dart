// WHAT YOU LEARN: Set<Marker>, stable MarkerId and InfoWindow.
// HOW TO RUN: flutter run -t lib/02_markers.dart (requires map-key setup).
// EXPECTED RESULT: the places icon toggles two sample pins near Beirut.
import 'package:flutter/material.dart';
import 'map_app.dart';

void main() => runApp(const MapsApp(enableMarkers: true));
