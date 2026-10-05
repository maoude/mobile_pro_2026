# Week 7 - Google Maps and location

These examples use `google_maps_flutter` and `location`. They require internet,
a Google Cloud project with billing configured, enabled Maps APIs, and restricted
platform API keys. Follow the current [Google Maps Flutter setup](https://developers.google.com/maps/flutter-package/config).
No key is included in the repository.

## Generate runners

```sh
cd code/week07/maps_examples
flutter pub get
flutter create --platforms=android,web .
```

On a Mac, add an iOS runner with `flutter create --platforms=ios .`.
The map plugin targets Android, iOS and web; the broader platform support of the
location plugin does not make this map app a Windows desktop app.
Use the requirements of the versions resolved in `pubspec.lock`, rather than the
old Android minSdk 20 or iOS preview flags in the supplied chapter.

## Android

Enable Maps SDK for Android. In `android/app/src/main/AndroidManifest.xml`, add
these permissions directly inside `<manifest>`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

Inside `<application>`, add the Maps key metadata:

```xml
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="YOUR_ANDROID_MAPS_KEY" />
```

Use a key restricted to your Android application ID, signing-certificate fingerprint,
and Maps SDK for Android. Keep your configured key out of committed source.
The project template's SDK defaults may need raising to match the plugin's minimums.

## iOS

Enable Maps SDK for iOS and restrict a separate key to the app's bundle identifier
and that SDK. Add `import GoogleMaps` in `ios/Runner/AppDelegate.swift`, then
`GMSServices.provideAPIKey("YOUR_IOS_MAPS_KEY")` in the launch method before the
existing plugin registration. Preserve the generated delegate structure.

Add to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Show your position on the course map when you tap the location button.</string>
```

This app uses foreground location only; it does not need background-location modes.
Use the installed Maps SDK's iOS deployment target requirements.

## Web

Enable Maps JavaScript API. Before the Flutter bootstrap script in `web/index.html`,
load the Maps JavaScript API as described in the plugin documentation:

```html
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_WEB_MAPS_KEY"></script>
```

Restrict this separate key to your permitted HTTP referrers and Maps JavaScript API.
Geolocation needs browser permission and a secure context (HTTPS or localhost).
If your browser cannot enable location services, change its settings and retry.

## Run

```sh
flutter run -t lib/00_fixed_map.dart
flutter run -t lib/01_user_location.dart
flutter run -t lib/02_markers.dart
flutter run -d chrome
```

| App | What to try |
|---|---|
| `00_fixed_map.dart` | Pan and zoom the fixed Beirut map; no location prompt |
| `01_user_location.dart` | Tap Find my location; allow permission or verify the error message on denial |
| `02_markers.dart` | Toggle two invented sample locations; tap a pin for its info window |
| `main.dart` | Combined location and sample-marker actions |

The sample markers are fixed teaching data near Beirut, not actual nearby restaurant
results. If you move the camera to a distant user position, return to Beirut to see them.
This app never silently substitutes Beirut for a failed location request.

## Live nearby-search extension

The lecture shows a Places API (New) POST request for a server-side extension.
It replaces the chapter's legacy nearby-search GET endpoint. Keep the Places web-service
credential on a backend; a key embedded in Dart (including `--dart-define`) is extractable.
The backend should authenticate callers, validate coordinates and radius, restrict
its key and return only the fields the app needs. Then map each result's stable ID,
coordinates and display name to a `Marker`. No live Places search or backend is supplied
by these sample-marker apps.

## Checks

```sh
flutter analyze
flutter test
```

Tests use a fake location gateway to cover service-disabled, denied, permanently denied,
granted and approximate-location permission states. They do not render a real map or
call the device's GPS. Map rendering and native configuration require a manual run with
your own key and device/browser.
