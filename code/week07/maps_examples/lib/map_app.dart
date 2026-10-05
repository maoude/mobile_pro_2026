import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_service.dart';

const beirut = LatLng(33.8938, 35.5018);

class MapsApp extends StatelessWidget {
  const MapsApp(
      {super.key, this.enableLocation = false, this.enableMarkers = false});
  final bool enableLocation;
  final bool enableMarkers;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MapPage(
            enableLocation: enableLocation, enableMarkers: enableMarkers),
      );
}

class MapPage extends StatefulWidget {
  const MapPage(
      {super.key, required this.enableLocation, required this.enableMarkers});
  final bool enableLocation;
  final bool enableMarkers;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _controller;
  LatLng? _position;
  bool _busy = false;
  bool _showSamples = false;
  String _message = 'Map centered on Beirut (fixed starting point).';

  Future<void> _locate() async {
    setState(() {
      _busy = true;
      _message = 'Finding your location...';
    });
    try {
      final point = await findUserLocation(DeviceLocationGateway());
      if (!mounted) return;
      await _controller?.animateCamera(CameraUpdate.newLatLngZoom(point, 15));
      if (!mounted) return;
      setState(() {
        _position = point;
        _message = 'Your coordinates: ${point.latitude.toStringAsFixed(4)}, '
            '${point.longitude.toStringAsFixed(4)}';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _message =
          'Location unavailable. Check permissions and device services, then retry.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Week 7: Packages and maps'),
          actions: [
            if (widget.enableLocation)
              IconButton(
                tooltip: 'Find my location',
                onPressed: _busy || _controller == null ? null : _locate,
                icon: const Icon(Icons.my_location),
              ),
            if (widget.enableMarkers)
              IconButton(
                tooltip: 'Show or hide sample markers',
                onPressed: () => setState(() => _showSamples = !_showSamples),
                icon: const Icon(Icons.place),
              ),
          ],
        ),
        body: Column(
          children: [
            Padding(padding: const EdgeInsets.all(12), child: Text(_message)),
            if (_busy) const LinearProgressIndicator(),
            Expanded(
              child: GoogleMap(
                initialCameraPosition:
                    const CameraPosition(target: beirut, zoom: 13),
                onMapCreated: (controller) {
                  if (!mounted) {
                    controller.dispose();
                    return;
                  }
                  setState(() => _controller = controller);
                },
                markers: {
                  if (_position != null)
                    Marker(
                        markerId: const MarkerId('user'),
                        position: _position!,
                        infoWindow: const InfoWindow(title: 'Your location')),
                  if (_showSamples) ...sampleMarkers,
                },
              ),
            ),
          ],
        ),
      );
}

// Invented teaching locations, not a live restaurant search.
final sampleMarkers = <Marker>{
  const Marker(
      markerId: MarkerId('sample-a'),
      position: LatLng(33.895, 35.503),
      infoWindow:
          InfoWindow(title: 'Sample restaurant A', snippet: 'Teaching data')),
  const Marker(
      markerId: MarkerId('sample-b'),
      position: LatLng(33.889, 35.498),
      infoWindow:
          InfoWindow(title: 'Sample restaurant B', snippet: 'Teaching data')),
};
