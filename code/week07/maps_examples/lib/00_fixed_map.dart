// WHAT YOU LEARN: GoogleMap, CameraPosition and LatLng.
// HOW TO RUN: flutter run -t lib/00_fixed_map.dart (requires map-key setup).
// EXPECTED RESULT: a pannable/zoomable map centered on Beirut, no location request.
import 'package:flutter/material.dart';
import 'map_app.dart';

void main() => runApp(const MapsApp());
