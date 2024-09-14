import 'package:flutter/material.dart';
import 'package:metroappinflutter/screen/metroo_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MetrooScreen(),
    );
  }
}

