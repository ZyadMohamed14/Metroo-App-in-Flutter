import 'package:flutter/material.dart';

class MetroAppBar extends StatelessWidget implements PreferredSizeWidget{

  final String title;


  // Constructor
  const MetroAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const  TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          )),
      backgroundColor: Colors.greenAccent,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set icon (including back arrow) color to white
        )
    );
  }
  // Defining the preferred size for the app bar
  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Standard AppBar height
}
