// Source: 002_lect_01_01.tex, section 3.1 Widget Tree Concepts
// Flutter app.

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Card App',
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(body: Center(child: Text('Hello'))),
    );
  }
}
