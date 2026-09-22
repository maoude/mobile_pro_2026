// =====================================================================
// Week 5, part 2 - State: lifting state up (sharing state between widgets)
// =====================================================================
// WHAT YOU LEARN
//   * Some state is needed by SEVERAL widgets: here the number of items in a
//     shopping cart is shown in the app bar (CartBadge), in the body
//     (CartSummary) and on the "Add" button, and it is changed by that button.
//     This is APP state (or shared state), not ephemeral state.
//   * A widget cannot read the private state of another widget. The simplest
//     solution is to LIFT THE STATE UP: keep it in the closest common
//     ancestor, here ShopPage. Then:
//       * the DATA flows DOWN, as constructor parameters (count);
//       * the EVENTS flow UP, as callback functions (onAdd), which the
//         ancestor implements with setState.
//   * It works well, but it has a cost. AddButton is three levels below
//     ShopPage, so Panel and Section must receive count and onAdd and pass them
//     on, without using them. In a big app this becomes heavy. The next
//     examples (08 and 09) remove this problem with a ChangeNotifier and the
//     provider package.
//
// HOW TO RUN
//   flutter run -t lib/07_lifting_state_up.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   An app bar with a cart icon and the number 0. In the body the text
//   "Items in the cart: 0" and, in a panel, a button "Add (0 in the cart)". Tap
//   the button: the three places show 1 at once, then 2, and so on. A button
//   CLEAR, in the body, sets everything back to 0.
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShopPage(),
    );
  }
}

// The state lives here, in the common ancestor of all the widgets that need it.
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _count = 0;

  void _add() {
    setState(() {
      _count++;
    });
  }

  void _clear() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifting state up'),
        centerTitle: true,
        actions: [CartBadge(count: _count)], // data DOWN
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CartSummary(count: _count), // data DOWN
            const SizedBox(height: 16),
            Panel(count: _count, onAdd: _add), // data DOWN, event UP
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _clear, child: const Text('CLEAR')),
          ],
        ),
      ),
    );
  }
}

// Stateless widgets: they show what they are given.
class CartBadge extends StatelessWidget {
  const CartBadge({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [const Icon(Icons.shopping_cart), Text('$count')],
      ),
    );
  }
}

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Items in the cart: $count',
        style: const TextStyle(fontSize: 18));
  }
}

// Panel and Section do not use count and onAdd: they only pass them down to
// AddButton. This is the cost of lifting the state up.
class Panel extends StatelessWidget {
  const Panel({super.key, required this.count, required this.onAdd});

  final int count;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Card(child: Section(count: count, onAdd: onAdd));
  }
}

class Section extends StatelessWidget {
  const Section({super.key, required this.count, required this.onAdd});

  final int count;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AddButton(count: count, onAdd: onAdd),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.count, required this.onAdd});

  final int count;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAdd, // the event goes UP
      child: Text('Add ($count in the cart)'),
    );
  }
}
