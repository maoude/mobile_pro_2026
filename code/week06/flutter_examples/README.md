# Week 6 - Restaurant menu

A Flutter app using the supplied `main.dart`, `home.dart` and `item.dart` files.
The app title is labeled Week 6.

## First-time setup

From the repository root:

```sh
cd code/week06/flutter_examples
flutter pub get
flutter create --platforms=web .
flutter run -d chrome
```

The platform-generation command adds the web runner. To run on Android instead,
generate it with `flutter create --platforms=android .`, select an emulator or
connected device, then run `flutter run`.

The images load from Unsplash and require internet access. Network-image loading
can depend on the selected platform and the image host's browser access rules.

## Files

| File | Purpose |
|---|---|
| `lib/main.dart` | Entry point and `MaterialApp` |
| `lib/home.dart` | Menu, checkboxes, total price, reset and named-route navigation |
| `lib/item.dart` | Item model, four sample items and `ShowSelectedItems` widget |
| `lib/selected_items_screen.dart` | Separate screen receiving the selected items |

## Try the app

1. Select Burger ($7) and Pizza ($10): the AppBar shows a total of $17.
2. Tap the shopping-cart icon to open the selected-items screen; use its AppBar back button to return.
3. Uncheck an item: its price is subtracted from the total.
4. Tap the reset icon: selections and total are cleared and the full menu returns.

The cart button calls `Navigator.pushNamed('/selected', arguments: selectedItems)`.
The route builder checks the `List<Item>` argument and passes it through the
`SelectedItemsScreen` constructor. Returning preserves the menu's state.
