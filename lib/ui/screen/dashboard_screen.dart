import 'package:flutter/material.dart';
import 'package:metroappinflutter/ui/screen/history_screen/history_page.dart';
import 'package:metroappinflutter/ui/screen/service_screen/service_screen.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/metroo_screen.dart';


class DashBoardScreen extends StatefulWidget {
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentIndex = 0;
 // Track the selected bottom nav item
  final List<Widget> _pages = [
    MetrooScreen(), // Home screen (Metro page)
    ServicesScreen(), // Historical places screen
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body:_pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // The currently selected item
          selectedItemColor: Colors.white, // Color of the selected label and icon
          unselectedItemColor: Colors.black45, // Color of unselected label and icon
          backgroundColor:Colors.greenAccent ,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update active tab
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.train),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),

          ],
        ),
      ),
    );
  }
}