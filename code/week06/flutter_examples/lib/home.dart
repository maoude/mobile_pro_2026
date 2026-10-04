import 'package:flutter/material.dart';
import 'item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _sum = 0; // holds total price for selected items

  List<Item> get selectedItems => items.where((item) => item.selected).toList();

  void _toggleSelection(int index, bool? value) {
    final item = items[index];
    final newValue = value ?? false;

    if (newValue == item.selected) {
      return;
    }

    setState(() {
      item.selected = newValue;
      if (newValue) {
        _sum += item.price;
      } else {
        _sum -= item.price;
      }
    });
  }

  void _resetSelection() {
    setState(() {
      _sum = 0;
      for (var item in items) {
        item.selected = false;
      }
    });
  }

  void _openSelectedItems() {
    if (_sum == 0) {
      return;
    }

    Navigator.of(context).pushNamed(
      '/selected',
      arguments: selectedItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      screenWidth = screenWidth * 0.8;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Total Price: \$$_sum'),
        centerTitle: true,
        actions: [
          Tooltip(
            message: 'Reset selection',
            child: IconButton(
              onPressed: _resetSelection,
              icon: const Icon(Icons.restore),
            ),
          ),
          Tooltip(
            message: 'Show selected items',
            child: IconButton(
              onPressed: _sum == 0 ? null : _openSelectedItems,
              icon: const Icon(Icons.shopping_cart_checkout),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            children: [
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.24),
                  Checkbox(
                    value: item.selected,
                    onChanged: (value) => _toggleSelection(index, value),
                  ),
                  Text(item.toString()),
                ],
              ),
              Image.network(item.image, height: screenWidth * 0.3),
            ],
          );
        },
      ),
    );
  }
}
