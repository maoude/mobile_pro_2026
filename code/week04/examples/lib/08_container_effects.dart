// =====================================================================
// Week 4, part 3 - Recipe: the Container and its visual effects
// =====================================================================
// WHAT YOU LEARN
//   * Container is a rectangle that you can size, space, color and draw.
//     Its main parameters:
//       width, height   the size
//       margin          empty space OUTSIDE the rectangle
//       padding         empty space INSIDE, between the edge and the child
//       alignment       where the child is placed inside the rectangle
//       decoration      how the rectangle is drawn (see below)
//       transform       a Matrix4 that rotates, moves or scales it
//       child           the widget inside
//   * decoration takes a BoxDecoration, whose parameters are:
//       color           the background color
//       border          Border.all(color: ..., width: ...)
//       borderRadius    BorderRadius.circular(16): rounded corners
//       boxShadow       a list of BoxShadow(color, blurRadius, offset)
//       gradient        LinearGradient(colors: [...]): a blend of colors
//       shape           BoxShape.rectangle (default) or BoxShape.circle
//   * Container(color: ...) is only a shortcut for
//     Container(decoration: BoxDecoration(color: ...)). You can NOT give both
//     color and decoration: Flutter stops with an assertion. Put the color
//     inside the BoxDecoration.
//
// HOW TO RUN
//   flutter run -t lib/08_container_effects.dart
//   (see ../README.md the first time: run "flutter create ." once)
//
// EXPECTED RESULT (on screen)
//   A scrollable page of six labelled boxes:
//     1. an amber box with a margin and a padding around its text
//     2. a white box with a blue border, rounded corners and a shadow
//     3. a box with a gradient from orange to purple
//     4. a green circle (a box of 80 x 80 with shape: BoxShape.circle)
//     5. a grey box with its text aligned at the bottom right corner
//     6. a teal box turned a little (a transform)
// =====================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Container effects')),
        body: const ContainerEffects(),
      ),
    );
  }
}

class ContainerEffects extends StatelessWidget {
  const ContainerEffects({super.key});

  // A small grey caption above each box.
  Widget _caption(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(text, style: const TextStyle(color: Colors.grey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _caption('1. margin (outside) and padding (inside)'),
          Container(
            key: const ValueKey('box1'),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(12),
            color: Colors.amber,
            child: const Text('margin 20, padding 12'),
          ),

          _caption('2. border, borderRadius and boxShadow'),
          Container(
            key: const ValueKey('box2'),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 3),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 8,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: const Text('A card made with a Container'),
          ),

          _caption('3. gradient'),
          Container(
            key: const ValueKey('box3'),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: 250,
            height: 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.purple],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),

          _caption('4. shape: BoxShape.circle'),
          Container(
            key: const ValueKey('box4'),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),

          _caption('5. alignment of the child'),
          Container(
            key: const ValueKey('box5'),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: 250,
            height: 100,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.bottomRight,
            color: Colors.grey[300],
            child: const Text('bottom right'),
          ),

          _caption('6. transform'),
          Container(
            key: const ValueKey('box6'),
            margin: const EdgeInsets.all(24),
            width: 150,
            height: 60,
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(-0.1),
            color: Colors.teal,
            child: const Text(
              'turned',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
