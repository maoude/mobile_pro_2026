import 'package:flutter/material.dart';
import 'item.dart';

class SelectedItemsScreen extends StatelessWidget {
  const SelectedItemsScreen({super.key, required this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Items'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            children: [
              const SizedBox(height: 10),
              Text(item.toString(), style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Image.network(item.image, height: 180),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
