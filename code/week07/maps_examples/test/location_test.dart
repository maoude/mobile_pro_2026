import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:week07_maps_examples/location_service.dart';

class FakeLocation implements LocationGateway {
  bool enabled = true;
  bool enableResult = false;
  PermissionStatus permission = PermissionStatus.granted;
  PermissionStatus requestResult = PermissionStatus.denied;
  int reads = 0;
  int requests = 0;
  @override
  Future<bool> serviceEnabled() async => enabled;
  @override
  Future<bool> requestService() async => enableResult;
  @override
  Future<PermissionStatus> hasPermission() async => permission;
  @override
  Future<PermissionStatus> requestPermission() async {
    requests++;
    return requestResult;
  }

  @override
  Future<LatLng> coordinates() async {
    reads++;
    return const LatLng(33.89, 35.50);
  }
}

void main() {
  test('granted permission returns real gateway coordinates', () async {
    final gateway = FakeLocation();
    expect(await findUserLocation(gateway), const LatLng(33.89, 35.50));
    expect(gateway.reads, 1);
  });
  test('disabled service does not read coordinates', () async {
    final gateway = FakeLocation()..enabled = false;
    await expectLater(findUserLocation(gateway), throwsStateError);
    expect(gateway.reads, 0);
  });
  test('denial requests permission but does not read coordinates', () async {
    final gateway = FakeLocation()..permission = PermissionStatus.denied;
    await expectLater(findUserLocation(gateway), throwsStateError);
    expect(gateway.requests, 1);
    expect(gateway.reads, 0);
  });
  test('permanent denial does not prompt again', () async {
    final gateway = FakeLocation()..permission = PermissionStatus.deniedForever;
    await expectLater(findUserLocation(gateway), throwsStateError);
    expect(gateway.requests, 0);
  });
  test('limited permission can return approximate coordinates', () async {
    final gateway = FakeLocation()
      ..permission = PermissionStatus.grantedLimited;
    expect(await findUserLocation(gateway), const LatLng(33.89, 35.50));
  });
}
