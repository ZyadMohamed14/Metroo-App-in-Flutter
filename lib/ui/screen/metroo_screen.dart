import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metroappinflutter/data/local/cario_lines.dart';
import 'package:metroappinflutter/data/local/coordinates.dart';
import 'package:metroappinflutter/data/local/metroo_app.dart';
import 'package:metroappinflutter/helper/location_helper.dart';
import 'package:metroappinflutter/ui/screen/station_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/di.dart';
import '../../domain/model/station.dart';
import '../presentation/map/maps_cubi_cubit.dart';
import '../widget/dialogs.dart';
import '../widget/metro_dropdownmenu.dart';
import 'map_screen.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
class MetrooScreen extends StatefulWidget {
  @override
  State<MetrooScreen> createState() => _MetrooScreenState();
}

class _MetrooScreenState extends State<MetrooScreen> {
  String? selectedStartStation;
  String? selectedEndStation;
  final startController = TextEditingController();
  final destenationController = TextEditingController();
  final addressController = TextEditingController();
  List<Station> stations = [];
  static late LatLng currentLocation;
  static late LatLng nearestStationLocation;
  static late LatLng destenationLocation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }
  void getCurrentLocation()async{
    await LocationHelper.getCurrentLocation();
    final currentposition =
    await Geolocator.getLastKnownPosition()
        .whenComplete(() {
      setState(() {});
    });
    currentLocation =LatLng(currentposition!.latitude, currentposition!.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Hello Zyad Mohamed',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make text bold
              fontSize: 18.0, // Set text size
            ),
          ),
        ),
        body: Stack(
          children: [
            // Background image with white opacity
            Opacity(
              opacity: 0.2, // Adjust opacity as needed
              child: Image.asset(
                'assets/metrobackground.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      // Start Stations Spinner
                      AppDropDownMenu(
                        textEditingController: startController,
                        title: "Select Station",
                        hint: startController.text.isEmpty
                            ? "Select Station"
                            : startController.text,
                        items: CairoLines.allCairoLines,
                        isCitySelected: true,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              // Get the current location of the user
                              if (currentLocation != null) {
                                suggestNearestRoute(
                                    context: context,
                                    controller: startController,
                                    latitude: currentLocation.latitude,
                                    longitude: currentLocation.longitude);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Your Location is not available",
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                                LocationHelper.checkPermission();
                              }
                            },
                            child: Text('Show Nearest station'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              bool isStationEmpty = startController.text.isNotEmpty;
                              bool isLocationFound = currentLocation != null;
                              if (isStationEmpty && isLocationFound) {
                                openMap(
                                  context: context,
                                  targetLocation: currentLocation,
                                  stationLocation: nearestStationLocation,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please Provide a Location",
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              }
                            },
                            child: Text('Show on Map'),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Reverse Data Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.sync),
                          onPressed: () {
                            // Implement reverse data function here
                          },
                        ),
                      ),
                      SizedBox(height: 64),

                      // End Stations Spinner
                      AppDropDownMenu(
                        textEditingController: destenationController,
                        title: "Select Station",
                        hint: destenationController.text.isEmpty
                            ? "Select Station"
                            : destenationController.text,
                        items: CairoLines.allCairoLines,
                        isCitySelected: true,
                      ),
                      Text(
                        "Search Nearest Station \n According to Your Destination Location",
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (destenationLocation != null) {
                                openMap(
                                  context: context,
                                  targetLocation: destenationLocation,
                                  stationLocation: nearestStationLocation,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please Enter Your Destination",
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              }
                            },
                            child: Text("Show on Map"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showAddressConfirmationSheet(context);
                            },
                            child: Text("Search"),
                          ),
                        ],
                      ),
                      Spacer(),

                      // Find My Route Button
                      ElevatedButton(
                        onPressed: findMyRoute,
                        child: Text('Find my Route'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void openMap({required BuildContext context,
    required LatLng targetLocation,
    required  LatLng stationLocation
  }
      ) {
    // final mylocation = LatLng(latitude, longitude);
    // final stationLocation = LatLng(stationPosition!.latitude, stationPosition!.longitude);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BlocProvider(
              create: (context) => getIt<MapsCubit>(),
              child: MapScreen(
                currentLocationposition: targetLocation,
                stationposition: stationLocation,
              ),
            ),
      ),
    );

  }

  void findMyRoute() {
    stations.clear();
    String start = startController.text;
    String end = destenationController.text;
    MetroApp metroApp = MetroApp(start, end);

    bool isValidData = metroApp.isValidData();
    if (isValidData) {
      metroApp.searchPath();
      List<List<String>> routes = metroApp.getRoutes();

      if (routes.length == 1) {
        Station station =
        Station(path: routes[0], direction: metroApp.getDirection());
        stations.add(station);
      } else {
        Station station1 = Station(
            path: routes[0],
            direction: metroApp.getDirectionForFirstRoute().toString());
        stations.add(station1);
        Station station2 = Station(
            path: routes[1],
            direction: metroApp.getDirectionForSecondRoute().toString());
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

  // Method to find and show the nearest station based on user location
  void suggestNearestRoute({
    required BuildContext context,
    required TextEditingController controller,
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Test if location services are enabled.

      LoadingDialog(context);

      // Variables to store the nearest station and shortest distance
      String? nearestStation;
      double shortestDistance = double.infinity;
      // Combine all metro lines into a single map
      Map<String, String> allStations = {
        ...CairoLinesCorrdinates.metroLine1Coordinates(),
        ...CairoLinesCorrdinates.metroLine2Coordinates(),
        ...CairoLinesCorrdinates.metroLine3Coordinates(),
      };

      // Iterate through each station
      for (MapEntry<String, String> station in allStations.entries) {
        // Split the coordinate string into latitude and longitude
        List<String> coordinates = station.value.split(',');

        double stationLatitude = double.parse(coordinates[0]);
        double stationLongitude = double.parse(coordinates[1]);

        // Calculate the distance between the user and the station
        double distance = Geolocator.distanceBetween(
          latitude,
          longitude,
          stationLatitude,
          stationLongitude,
        );

        // Update the nearest station if this one is closer
        if (distance < shortestDistance) {
          shortestDistance = distance;
          nearestStation = station.key; // Store the station name
          // Store the station position
          nearestStationLocation = LatLng(stationLatitude, stationLongitude);
        }
      }

      // Display the nearest station if found
      if (nearestStation != null) {
        Fluttertoast.showToast(
          msg:
          'Nearest Station: $nearestStation - ${shortestDistance
              .toStringAsFixed(2)} meters away',
          toastLength: Toast.LENGTH_LONG,
        );
        controller.text = nearestStation ?? '';
      } else {
        Fluttertoast.showToast(
          msg: 'No stations found nearby',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
      // Handle any errors in fetching location
      print('Error fetching location: ${e.toString()}');
      Fluttertoast.showToast(
        msg: 'Error fetching location: ${e.toString()}',
        toastLength: Toast.LENGTH_SHORT,
      );
    } finally {
      // Dismiss the progress dialog after the operation is complete
      Navigator.of(context).pop();
    }
  }

  void getLocationFromAddress(BuildContext context,
      String address,
      TextEditingController controller,) async {
    final response = await LocationHelper.getLatLngFromAddress(address);

    response.fold(
          (errorMessage) {

        // Show error dialog when there is an error
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
          (location) {
        destenationLocation = LatLng(location.latitude, location.longitude);
        suggestNearestRoute(
            context: context,
            controller: controller,
            latitude: destenationLocation.latitude,
            longitude: destenationLocation.longitude);

        // You can use the location for further actions, like navigating to a map screen
        // Or passing the latitude and longitude to another function
      },
    );
  }

  void showAddressConfirmationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: Get.height/1.5,
            child: Column(

              children: [
                // TextField with hint 'Confirm Address'
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Address',
                    hintText: 'Enter your address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                // Confirm Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String address = addressController.text;
                        if (address.isNotEmpty) {
                          getLocationFromAddress(context, address,destenationController);

                          // Navigator.pop(context); // Close the bottom sheet
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please Provide an Address ",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      },
                      child: Text('Confirm'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancle'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
