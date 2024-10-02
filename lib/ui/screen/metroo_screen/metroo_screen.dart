
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metroappinflutter/data/local/coordinates.dart';
import 'package:metroappinflutter/data/local/metroo_app.dart';
import 'package:metroappinflutter/helper/location_helper.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/enable_service_text.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/metro_dropdownmenu.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/nearst_statation_details.dart';
import 'package:metroappinflutter/ui/screen/station-detils_screen/station_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/address_confirmation_sheet.dart';
import 'package:metroappinflutter/ui/shared_widgets/app_button.dart';
import 'package:metroappinflutter/ui/shared_widgets/dialogs.dart';
import '../../../di/di.dart';
import '../../../domain/model/station.dart';
import '../../presentation/map/maps_cubi_cubit.dart';
import '../map-screen/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class MetrooScreen extends StatefulWidget {
  @override
  State<MetrooScreen> createState() => _MetrooScreenState();
}

class _MetrooScreenState extends State<MetrooScreen> {
  final startController = TextEditingController();
  final destinationController = TextEditingController();
  final addressController = TextEditingController();
  List<Station> stations = [];
  // Observables
  var currentLocation = Rxn<LatLng>();
  var nearestStationLocation = Rxn<LatLng>();
  var destinationLocation = Rxn<LatLng>();

  // Variables to store the nearest station and shortest distance
  var nearestStation = "".obs; // String? as RxnString
  var shortestDistance = Rx<double>(double.infinity); // double as Rx
  var isServiceEnabled = false.obs;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();

  }

  void getCurrentLocation() async {
    await LocationHelper.getCurrentLocation();

    final currentposition =
    await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });
    print('komosu ${currentposition!.longitude}');
    if (!currentposition.isNull) {
      currentLocation.value =
          LatLng(currentposition.latitude, currentposition.longitude);
      await findNearestStation(
          controller: startController,
          latitude: currentposition.latitude,
          longitude: currentposition.longitude);
      setState(() {});
    } else {
      Fluttertoast.showToast(
        msg: "Location Services Disabled",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: Get.height -
                  Get.mediaQuery.padding.top,
              child: Column(
                children: [
                  // Space between button and dropdowns
                  Text("Welcome To Cairo Metro \n We will Help You to Go Any Where"
                  ,style: GoogleFonts.gowunBatang(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                  ),
                  const SizedBox(height: 4),
                  AppDropDownMenu(
                    title: "Origin",
                    hint: "Select  Your Origin",
                    textEditingController: startController,
                    isCitySelected: true,
                    //  direction: "",
                  ),

                  // Space between dropdowns (optional)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.sync, color: Colors.green,size: 30,),
                      onPressed: () {
                        String temp = startController.text;
                        startController.text = destinationController.text;
                        destinationController.text = temp;
                      },
                    ),
                  ),

                  // Destination Stations Dropdown
                  AppDropDownMenu(
                    title: "Destination",
                    hint: "Select  Your Destination",
                    textEditingController: destinationController,
                    isCitySelected: true,
                    //  direction: "",
                  ),

                  const SizedBox(height: 32),
                  // Find My Route Button
                  MetrooAppButton(
                    icon: Icons.route,
                    label: 'Show My Route',
                    onPressed: findMyRoute,
                    isLarge: true,
                  ),


                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        "Search Nearest Station \n According to Your Destination",
                        style: GoogleFonts.gowunBatang(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,

                      ),
                      const SizedBox(width: 8),
                      MetrooAppButton(
                        icon: Icons.search,
                        label: 'Search',
                        onPressed: () {
                          showAddressConfirmationSheet();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Obx(() {
                    return nearestStation.value.isNotEmpty
                        ? NearestStationDetails(
                            nearestStation: nearestStation.value,
                            shortestDistance: shortestDistance.value,
                          )
                        : EnableServiceText(getCurrentLocation: getCurrentLocation,);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openMap(
      {required LatLng targetLocation, required LatLng stationLocation}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
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
    String end = destinationController.text;
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
  Future<void> findNearestStation({
    required TextEditingController controller,
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Test if location services are enabled.

      showDialog(
        context: context,
        barrierDismissible: false, // Prevents dismissal by tapping outside
        builder: (BuildContext context) {
          return const LoadingDialog(); // Create and show the loading dialog
        },
      );

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
        if (distance < shortestDistance.value) {
          shortestDistance.value = distance;
          nearestStation.value = station.key; // Store the station name
          // Store the station position
          nearestStationLocation.value =
              LatLng(stationLatitude, stationLongitude);
        }
      }

      // Display the nearest station if found
      if (nearestStation.value.isNotEmpty) {
        Fluttertoast.showToast(
          msg:
              'Nearest Station: ${nearestStation.value} - ${shortestDistance.toStringAsFixed(2)} meters away',
          toastLength: Toast.LENGTH_LONG,
        );
        controller.text = nearestStation.value ?? '';
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

  void getLocationFromAddress(
    String address,
    TextEditingController controller,
  ) async {
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
        destinationLocation.value =
            LatLng(location.latitude, location.longitude);
        findNearestStation(
            controller: controller,
            latitude: destinationLocation.value!.latitude,
            longitude: destinationLocation.value!.longitude);

        // You can use the location for further actions, like navigating to a map screen
        // Or passing the latitude and longitude to another function
      },
    );
  }

  void showAddressConfirmationSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AddressConfirmationSheet(
          addressController: addressController,
          destinationController: destinationController,
          getLocationFromAddress: getLocationFromAddress,
        );
      },
    );
  }

}
