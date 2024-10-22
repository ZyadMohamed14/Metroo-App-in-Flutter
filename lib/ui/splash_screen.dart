import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:metroappinflutter/ui/screen/dashboard_screen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    // Navigate to DashBoardScreen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Get.off(DashBoardScreen()); // Replace current screen with DashBoard
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.greenAccent,  // Equivalent to background(lightGreen)
        child: Center(
          child: Container(
            width: 100.0,
            height: 100.0,  // Size of the circle
            decoration: BoxDecoration(
              color: Colors.white,  // Circle color
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black54,  // Dark gray border color
                width: 4.0,
              ),
            ),
            child: Center(
              child: Text(
                'M',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}