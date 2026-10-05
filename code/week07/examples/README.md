# Week 7 - Packages practice

From the repository root:

```sh
cd code/week07/examples
flutter pub get
flutter analyze
flutter test
flutter create --platforms=web .
flutter run -d chrome
```

The default app is the area calculator. Generate other platform runners if required;
keep the supplied `lib`, `test` and `pubspec.yaml` files.

| Command | Expected result |
|---|---|
| `flutter run -t lib/00_number_format.dart` | US and German number formatting, plus a value rounded for display |
| `flutter run -t lib/01_http_request.dart` | Loading indicator, then a post title, or an error with Retry |
| `flutter run -t lib/02_area_calculator.dart` | Width 4, height 3 → rectangle 12 or triangle 6; invalid input is rejected |

HTTP uses JSONPlaceholder, a public demonstration service. Its availability is external
to this course; automated checks use `MockClient`. On Android add
`<uses-permission android:name="android.permission.INTERNET" />` directly inside
the main manifest's `<manifest>` element for release builds. macOS needs the outgoing
network client entitlement. Browser requests are subject to CORS.

The `area` package is referenced through `path: packages/area`. It depends on `intl`;
the app also declares `intl` directly because `00_number_format.dart` imports it.
Calculations return numbers; `formatArea` handles presentation separately.

## Check the custom package

```sh
cd packages/area
dart pub get
dart analyze
dart test
```

Keep its tests when experimenting. Compare ordinary `export` libraries with the
`part` / `part of` explanation in the lecture. Do not publish this generic practice
package to pub.dev. `publish_to: 'none'` prevents accidental publishing.

The app lockfile records tested resolutions. When upgrading, use `flutter pub outdated`,
review compatibility and rerun analysis/tests.
