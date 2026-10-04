import 'package:flutter/material.dart';

class Item {
  final String _name;
  final double _price;
  bool _selected = false; // determines if an item is selected from the menu
  final String _image; // holds image url

  Item(this._name, this._price, this._image);

  // getters and setters
  String get name => _name;
  double get price => _price;
  bool get selected => _selected;
  String get image => _image;
  set selected(bool e) => _selected = e;

  // item description is displayed in the ListView
  @override
  String toString() {
    String space = ''; // loop computes spaces between price and name
    for (int i = 0; i < 3 - _price.toString().length; i++) {
      space += ' ';
    }
    return 'Price: \$$_price $space$_name';
  }
}

// list of items, used to populate ListView
List<Item> items = [
  Item('Burger', 7,
      "https://plus.unsplash.com/premium_photo-1667682209935-b6c87cced668?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8YnVyZ2VyfGVufDB8fDB8fHww"),
  Item('Pizza', 10,
      "https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  Item('Salad', 6,
      "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  Item('Fresh Juice', 5,
      "https://images.unsplash.com/photo-1579954115545-a95591f28bfc?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
];


class ShowSelectedItems extends StatelessWidget {
  const ShowSelectedItems({required this.width, Key? key}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
      List<Item> selectedItems = [];
      for (var e in items) {
        if (e.selected) {
          selectedItems.add(e);
        }
      }
      return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: selectedItems.length,
        itemBuilder: (context, index) {
          return Column(children: [
            const SizedBox(height: 10),
              SizedBox(width: width * 0.28),
              Text(selectedItems[index].toString(), style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
            // get image from url stored in Item image field
            Image.network(selectedItems[index].image,
                height: width * 0.3),
            const SizedBox(height: 10),
          ]);
        },
      );
  }
}

