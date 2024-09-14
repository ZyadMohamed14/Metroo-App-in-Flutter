import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metroappinflutter/data/cario_lines.dart';
import 'package:metroappinflutter/data/metroo_app.dart';
import 'package:metroappinflutter/screen/station_screen.dart';
import 'package:metroappinflutter/widget/stattion_item.dart';
import 'package:metroappinflutter/widget/metro_dropdownmenu.dart';

import '../data/station.dart';

class MetrooScreen extends StatefulWidget {
  @override
  State<MetrooScreen> createState() => _MetrooScreenState();
}

class _MetrooScreenState extends State<MetrooScreen> {
  String? selectedStartStation;
  String? selectedEndStation;
  final  TextEditingController startEditingController = TextEditingController();
  final  TextEditingController endEditingController = TextEditingController();
  List<Station>stations =[];

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Start Stations Spinner
             AppDropDownMenu(textEditingController: startEditingController,
              title: "Select Station",
              hint: startEditingController.text.isEmpty?"Select Station":startEditingController.text,
              items: CairoLines.allCairoLines,
              isCitySelected: true)
              ,
      
              SizedBox(height: 16),
      
              // Reverse Data Button
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.sync),
                  onPressed: () {
                    // Implement revresdata function here
                  },
                ),
              ),
              SizedBox(height: 64),
      
              // End Stations Spinner
              AppDropDownMenu(textEditingController: endEditingController,
                  title: "Select Station",
                  hint: startEditingController.text.isEmpty?"Select Station":endEditingController.text,
                  items: CairoLines.allCairoLines,
                  isCitySelected: true),
              Spacer(),
      
              // Find My Route Button
              ElevatedButton(
                onPressed:findMyRoute,
                child: Text('Find my Rout'),
              ),
              SizedBox(height: 16),
      
              // Suggest My Route Button
              ElevatedButton(
                onPressed: () {
                  // Implement suggetRout function here
                },
                child: Text('Suggest My Route'),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
  void findMyRoute() {
    stations.clear();
    String start = startEditingController.text;
    String end = endEditingController.text;
    MetroApp metroApp = MetroApp(start, end);

    bool isValidData = metroApp.isValidData();
    if (isValidData) {
      metroApp.searchPath();
      List<List<String>> routes = metroApp.getRoutes();

      if (routes.length == 1) {
        Station station = Station(path: routes[0], direction: metroApp.getDirection());
        stations.add(station);
      } else {
        Station station1 = Station(path: routes[0], direction: metroApp.getDirectionForFirstRoute().toString());
        stations.add(station1);
        Station station2 = Station(path: routes[1], direction: metroApp.getDirectionForSecondRoute().toString());
        stations.add(station2);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StationDetailsScreen(stations: stations),
        ),
      );

    } else {
      Fluttertoast.showToast(
        msg: "Please Enter Valid Data",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}