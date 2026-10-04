/*
program to display restaurant menu
allows user to select items and then computes total price
demonstrates the use of:
ListView
IconButton
adding icons to AppBar
Navigator routes
passing data between screens
*/

import 'package:flutter/material.dart';
import 'home.dart';
import 'item.dart';
import 'selected_items_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week 6: Restaurant Menu',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/selected': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          final selectedItems = arguments is List<Item> ? arguments : const <Item>[];
          return SelectedItemsScreen(items: selectedItems);
        },
      },
    );
  }
}
