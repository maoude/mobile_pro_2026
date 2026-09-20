// Source: 002_lect_01_01.tex, section 3.3 Lifecycle - Resource Management
// Flutter widget; needs an import of package:flutter/material.dart.

class TimerDemo extends StatefulWidget {
  const TimerDemo({super.key});
  @override
  State<TimerDemo> createState() => _TimerDemoState();
}

class _TimerDemoState extends State<TimerDemo> with WidgetsBindingObserver {
  // e.g., Timer, controllers, or tickers

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // init resources
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // dispose resources
    super.dispose();
  }
}
