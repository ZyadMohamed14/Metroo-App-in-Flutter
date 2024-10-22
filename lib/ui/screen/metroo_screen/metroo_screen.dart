import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metroappinflutter/data/local/cario_lines.dart';
import 'package:metroappinflutter/data/local/coordinates.dart';
import 'package:metroappinflutter/data/local/metroo_app.dart';
import 'package:metroappinflutter/domain/model/map_modle.dart';
import 'package:metroappinflutter/helper/location_helper.dart';
import 'package:metroappinflutter/language/app_locale.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/enable_service_text.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/metro_dropdownmenu.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/nearst_statation_details.dart';
import 'package:metroappinflutter/ui/screen/station-detils_screen/station_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/address_confirmation_sheet.dart';
import 'package:metroappinflutter/ui/screen/test.dart';
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
  late String currentLanguage;
  Map<String, String> allStationsCoordinates = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLanguage = Get.locale!.languageCode;
    print(currentLanguage);
    getCurrentLocation();

  }

  void getCurrentLocation() async {
    await LocationHelper.getCurrentLocation();

    final currentposition =
        await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });


    if (currentposition != null) {
      currentLocation.value =
          LatLng(currentposition.latitude, currentposition.longitude);
      await findNearestStation(
          controller: startController,
          latitude: currentposition.latitude,
          longitude: currentposition.longitude);
      setState(() {});
    } else {
      Fluttertoast.showToast(
        msg: "Location Services Disabled".tr,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch metro station items based on language
    final cairoLines = CairoLines.allCairoLines;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: Get.height - Get.mediaQuery.padding.top,
              child: Column(
                children: [
                  // Space between button and dropdowns
                  Text(
                    '${'welcome'.tr}\n${'help'.tr}',
                    style: GoogleFonts.gowunBatang(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AppDropDownMenu(
                    title: "origin".tr,
                    hint: "select_your_origin".tr,
                    textEditingController: startController,
                    isCitySelected: true,
                    items: cairoLines,
                    //  direction: "",
                  ),
                  // Space between dropdowns (optional)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.sync,
                        color: Colors.green,
                        size: 30,
                      ),
                      onPressed: () {
                        String temp = startController.text;
                        startController.text = destinationController.text;
                        destinationController.text = temp;
                      },
                    ),
                  ),

                  // Destination Stations Dropdown
                  AppDropDownMenu(
                    title: "destination".tr,
                    hint: "select_your_destination".tr,
                    textEditingController: destinationController,
                    isCitySelected: true,
                    items: cairoLines,
                  ),

                  const SizedBox(height: 32),
                  // Find My Route Button
                  MetrooAppButton(
                    icon: Icons.route,
                    label: 'show_my_route'.tr,
                    onPressed: findMyRoute,
                    isLarge: true,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "search_nearest_station".tr,
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
                        label: 'search'.tr,
                        onPressed: () {
                          showAddressConfirmationSheet();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Obx(() {

                    return nearestStation.value.isNotEmpty && currentLocation.value != null && nearestStationLocation.value != null
                        ? NearestStationDetails(
                            nearestStation: nearestStation.value,
                            shortestDistance: shortestDistance.value,
                            currentLanguage: currentLanguage,
                      onOpenMap: () {
                        // Call the openMap function and pass the locations
                        openMap(
                          targetLocation: currentLocation.value!,
                          stationLocation: nearestStationLocation.value!,
                        );
                      },
                          )
                        : EnableServiceText(
                            getCurrentLocation: getCurrentLocation,
                          );
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
            Station(path: routes[0], direction: metroApp.getDirection(),
            );

        stations.add(station);
      } else {
        Station station1 = Station(
            path: routes[0],
            direction: metroApp.getDirectionForFirstRoute().toString());
        station1.transList.addAll(metroApp.transList1);

        stations.add(station1);
        Station station2 = Station(
            path: routes[1],
            direction: metroApp.getDirectionForSecondRoute().toString());
        station2.transList.addAll(metroApp.transList2);
        print(metroApp.transList2);
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
        msg: "please_enter_valid_data".tr,
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
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissal by tapping outside
      builder: (BuildContext context) {
        return const LoadingDialog(); // Create and show the loading dialog
      },
    );

    try {

      allStationsCoordinates =CairoLinesCorrdinates.allMetroCoordinates();


      // Iterate through each station
      for (MapEntry<String, String> station in allStationsCoordinates.entries) {
        print(station);
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
          nearestStation.value = station.key.tr; // Store the station name
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
          msg: 'no_stations_found'.tr,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
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
        print(errorMessage);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('error'.tr),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ok'.tr),
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
