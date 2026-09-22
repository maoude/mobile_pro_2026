// =====================================================================
// Week 5, part 2 - State: app state with the provider package
// =====================================================================
// WHAT YOU LEARN
//   * provider is a package (in pubspec.yaml: provider) that makes the
//     ChangeNotifier models of example 08 available to the whole widget tree,
//     so a widget anywhere can read them without receiving them as parameters.
//     It is the right tool for APP state: the state that many screens share and
//     that lives longer than one screen (a cart, the user's settings, a login).
//   * Three ideas:
//       ChangeNotifier          the model; it calls notifyListeners()
//                               (see example 08)
//       ChangeNotifierProvider  a widget that CREATES a model and gives it to
//                               all the widgets below it: create: (_) => Model()
//                               It also calls dispose() on the model when it is
//                               no longer needed.
//       Consumer<Model>         a widget that finds the model, and rebuilds its
//                               builder(context, model, child) each time the
//                               model notifies. child is a part of the tree
//                               that does not depend on the model: it is built
//                               once and passed back, to save work.
//   * MultiProvider gives several models at once, without nesting providers one
//     inside the other. Here: CartModel and SettingsModel.
//   * Other ways to find a model from a BuildContext:
//       context.watch<T>()      read AND rebuild when it changes (in build)
//       context.read<T>()       read only, no rebuild (in callbacks: onPressed)
//       context.select<T, R>()  rebuild only when the part you select changes
//   * The provider is placed ABOVE the MaterialApp, so that every screen, also
//     the ones opened with Navigator.push, sees the same cart.
//   * Put a Consumer (or a select) as deep in the tree as possible: only the
//     small part that needs the data is rebuilt.
//   * Do not forget notifyListeners() in the model, or the screen will not
//     change; and never change the model from build().
//
// HOW TO RUN
//   flutter pub get       (provider must be downloaded the first time)
//   flutter run -t lib/09_provider_cart.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A page "Catalog" with three products (Coffee 3.00, Tea 2.00, Cake 5.00), a
//   cart icon in the app bar, and a moon icon. Tap the cart button of a product:
//   the badge on the cart icon shows the number of items. Tap the cart icon: a
//   page "Cart" lists the items, the total, and a button to remove each item.
//   Go back: the badge is still right. Tap the moon icon: the whole app (both
//   pages) switches to the dark theme; the icon becomes a sun.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const ShopApp());

// ------------------------------------------------------------------ models

class Item {
  const Item(this.name, this.price);

  final String name;
  final double price;
}

const List<Item> products = [
  Item('Coffee', 3),
  Item('Tea', 2),
  Item('Cake', 5),
];

// The cart: a list of items, shared by the catalog and the cart page.
class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  double get total => _items.fold(0, (sum, item) => sum + item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// The user's preferences.
class SettingsModel extends ChangeNotifier {
  bool _dark = false;

  bool get dark => _dark;

  void toggleDark() {
    _dark = !_dark;
    notifyListeners();
  }
}

// -------------------------------------------------------------------- app

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => SettingsModel()),
      ],
      // The theme depends on the settings: a Consumer around MaterialApp.
      child: Consumer<SettingsModel>(
        builder: (context, settings, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: settings.dark ? ThemeData.dark() : ThemeData.light(),
            home: const CatalogPage(),
          );
        },
      ),
    );
  }
}

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: const [ThemeButton(), CartButton()],
      ),
      body: ListView(
        children: [
          for (final item in products)
            ListTile(
              title: Text(item.name),
              subtitle: Text(item.price.toStringAsFixed(2)),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                tooltip: 'Add ${item.name}',
                // In a callback we only READ the model: context.read.
                onPressed: () => context.read<CartModel>().add(item),
              ),
            ),
        ],
      ),
    );
  }
}

// Rebuilt only when the NUMBER of items changes (context.select).
class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.select<CartModel, int>((cart) => cart.items.length);
    return IconButton(
      tooltip: 'Open the cart',
      icon: Badge(
        label: Text('$count'),
        isLabelVisible: count > 0,
        child: const Icon(Icons.shopping_cart),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CartPage()),
        );
      },
    );
  }
}

// A Consumer: rebuilt every time the settings notify.
class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, settings, child) {
        return IconButton(
          tooltip: 'Change the theme',
          icon: Icon(settings.dark ? Icons.light_mode : Icons.dark_mode),
          onPressed: settings.toggleDark,
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Column(
            children: [
              child!, // built once, does not depend on the cart
              Expanded(
                child: ListView(
                  children: [
                    for (final item in cart.items)
                      ListTile(
                        title: Text(item.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          tooltip: 'Remove ${item.name}',
                          onPressed: () => cart.remove(item),
                        ),
                      ),
                  ],
                ),
              ),
              Text('Total: ${cart.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20)),
              TextButton(
                onPressed: cart.clear,
                child: const Text('CLEAR'),
              ),
            ],
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Your items', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
