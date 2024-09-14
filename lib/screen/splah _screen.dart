import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const int splashDuration = 3000; // 3 seconds
  SharedPreferences? preferences;

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  void startSplashScreen() async {
    preferences = await SharedPreferences.getInstance();
    bool isTravelExist = preferences?.getBool('TRAVELEXISTS') ?? false;

    // Show a toast message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("isTravelExist: $isTravelExist")),
    );

    Timer(Duration(milliseconds: splashDuration), () {
      if (isTravelExist) {
        Navigator.of(context).pushReplacementNamed('/routActivity');
      } else {
        Navigator.of(context).pushReplacementNamed('/metrooScreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Metro App',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}