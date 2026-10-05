// WHAT YOU LEARN: named routes, typed arguments, onGenerateRoute,
// category filtering, detail lookup, enums and a result returned by pop.
// HOW TO RUN: flutter run -t lib/07_named_routes.dart
// EXPECTED RESULT: choose Food, open Burger, choose it, then see
// "Chosen: Burger" on the list. Back returns to the categories.
import 'package:flutter/material.dart';

void main() => runApp(const NavigationApp());

enum ItemKind { meal, drink }

class MenuEntry {
  const MenuEntry(this.id, this.category, this.title, this.kind);
  final String id;
  final String category;
  final String title;
  final ItemKind kind;
}

const menuEntries = [
  MenuEntry('burger', 'Food', 'Burger', ItemKind.meal),
  MenuEntry('salad', 'Food', 'Salad', ItemKind.meal),
  MenuEntry('juice', 'Drinks', 'Fresh juice', ItemKind.drink),
];

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Week 6: Named routes',
        initialRoute: '/',
        routes: {'/': (context) => const CategoriesPage()},
        onGenerateRoute: (settings) {
          final argument = settings.arguments;
          if (settings.name == CategoryPage.routeName &&
              argument is String &&
              ['Food', 'Drinks'].contains(argument)) {
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (context) => CategoryPage(category: argument),
            );
          }
          if (settings.name == DetailPage.routeName && argument is String) {
            // Check existence before firstWhere, which otherwise throws.
            if (menuEntries.any((entry) => entry.id == argument)) {
              final entry =
                  menuEntries.firstWhere((entry) => entry.id == argument);
              return MaterialPageRoute<String>(
                settings: settings,
                builder: (context) => DetailPage(entry: entry),
              );
            }
          }
          // Known routes with invalid arguments get a visible error.
          if (settings.name == CategoryPage.routeName ||
              settings.name == DetailPage.routeName) {
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (context) => const RouteErrorPage(),
            );
          }
          return null; // Let onUnknownRoute handle other names.
        },
        onUnknownRoute: (settings) => MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const RouteErrorPage(),
        ),
      );
}

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Categories')),
        body: ListView(
          children: [
            for (final category in ['Food', 'Drinks'])
              ListTile(
                title: Text(category),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).pushNamed<void>(
                  CategoryPage.routeName,
                  arguments: category,
                ),
              ),
          ],
        ),
      );
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.category});
  static const routeName = '/category';
  final String category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? _chosen;

  Future<void> _openDetail(MenuEntry entry) async {
    final result = await Navigator.of(context).pushNamed<String>(
      DetailPage.routeName,
      arguments: entry.id,
    );
    if (!mounted || result == null) return;
    setState(() => _chosen = result);
  }

  @override
  Widget build(BuildContext context) {
    final entries = menuEntries
        .where((entry) => entry.category == widget.category)
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(
        children: [
          if (_chosen != null) Text('Chosen: $_chosen'),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(entries[index].title),
                onTap: () => _openDetail(entries[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.entry});
  static const routeName = '/detail';
  final MenuEntry entry;

  @override
  Widget build(BuildContext context) {
    final kindText = switch (entry.kind) {
      ItemKind.meal => 'Meal',
      ItemKind.drink => 'Drink',
    };
    return Scaffold(
      appBar: AppBar(title: Text(entry.title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(kindText),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop<String>(entry.title),
              child: const Text('Choose this item'),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteErrorPage extends StatelessWidget {
  const RouteErrorPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Navigation error')),
        body: const Center(child: Text('Unknown route or invalid arguments.')),
      );
}
