# area

A local teaching package: rectangle and triangle areas with validated dimensions,
and locale-aware display formatting through `intl`.

```dart
import 'package:area/area.dart';

final value = rectangleArea(4, 3); // 12
final label = formatArea(value);  // '12'
```

Dimensions must be finite and positive; unsupported overflow throws `ArgumentError`.
Run `dart pub get`, `dart analyze`, and `dart test` in this directory.
The public entry point exports ordinary libraries under `lib/src`.
`publish_to: 'none'` keeps this exercise private. It has not been published.
Before any publication, choose appropriate ownership, licensing and metadata.
