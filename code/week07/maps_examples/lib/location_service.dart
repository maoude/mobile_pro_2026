import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

abstract interface class LocationGateway {
  Future<bool> serviceEnabled();
  Future<bool> requestService();
  Future<PermissionStatus> hasPermission();
  Future<PermissionStatus> requestPermission();
  Future<LatLng> coordinates();
}

class DeviceLocationGateway implements LocationGateway {
  final Location _location = Location();

  @override
  Future<bool> serviceEnabled() => _location.serviceEnabled();
  @override
  Future<bool> requestService() => _location.requestService();
  @override
  Future<PermissionStatus> hasPermission() => _location.hasPermission();
  @override
  Future<PermissionStatus> requestPermission() => _location.requestPermission();
  @override
  Future<LatLng> coordinates() async {
    final data = await _location.getLocation();
    return LatLng(data.latitude, data.longitude);
  }
}

/// Requests a foreground position only; failure never becomes a fake position.
Future<LatLng> findUserLocation(LocationGateway gateway) async {
  if (!await gateway.serviceEnabled() && !await gateway.requestService()) {
    throw StateError('Enable location services in device settings.');
  }
  var permission = await gateway.hasPermission();
  if (permission == PermissionStatus.denied) {
    permission = await gateway.requestPermission();
  }
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.grantedLimited) {
    throw StateError('Location permission is unavailable. Check app settings.');
  }
  return gateway.coordinates().timeout(const Duration(seconds: 15));
}
