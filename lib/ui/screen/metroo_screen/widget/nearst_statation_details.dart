import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metroappinflutter/data/local/cario_lines.dart';
import 'package:metroappinflutter/language/app-locale_contoller.dart';
import 'package:metroappinflutter/ui/shared_widgets/app_button.dart';
import 'package:get/get.dart';

class NearestStationDetails extends StatelessWidget {
  final String nearestStation;
  final String currentLanguage;
  final double shortestDistance;

  const NearestStationDetails({
    super.key,
    required this.nearestStation,
    required this.shortestDistance,
    required this.currentLanguage
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.greenAccent, width: 2.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          const SizedBox(height: 12.0),
          _buildStationNameRow(),
          const SizedBox(height: 12.0),
          _buildDistanceRow(),
          const SizedBox(height: 12.0),
          _buildMetroRow(),
          const SizedBox(height: 20.0),
          Center(
            child: MetrooAppButton(
              icon: Icons.map,
              label: 'show_on_map'.tr,
              onPressed: () {
               // print("Show on Map pressed for: $nearestStation");
              },
              isLarge: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Text(
      'nearest_station'.tr,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStationNameRow() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_rounded, // Runner icon
          color: Colors.red,
          size: 24.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          nearestStation, // Show distance in km
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceRow() {
    // Calculate distance in kilometers
    double distanceInMeters = shortestDistance; // Convert to km
// '${'km_away_with_value'.tr} ${distanceInKm.toStringAsFixed(2)} ${'km'.tr}'
    return Row(
      children: [
        const Icon(
          Icons.directions_run, // Runner icon
          color: Colors.blue,
          size: 24.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          '${'km_away_with_value'.tr} ${_getDistanceString(distanceInMeters)}',
          // Show distance in km
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildMetroRow() {
    return Row(
      children: [
        const Icon(
          Icons.train, // Runner icon
          color: Colors.orange,
          size: 24.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          searchStation(nearestStation), // Show distance in km
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  String searchStation(String station) {

    var transitionStation =currentLanguage=='ar'? CairoLines.transitionStationAr:CairoLines.transitionStation;
    var metroLine1 = currentLanguage=='ar'?CairoLines.cairoLine1Ar():CairoLines.cairoLine1();
    var metroLine2 = currentLanguage=='ar'?CairoLines.cairoLine2Ar():CairoLines.cairoLine2();
    var metroLine3 = currentLanguage=='ar'?CairoLines.cairoLine3Ar():CairoLines.cairoLine3();

    if (transitionStation.containsKey(station)) {
      return transitionStation[station]!; // Access value directly using the key
    } else if (metroLine1.contains(station)) {
      return "metro_line_1".tr;
    } else if (metroLine2.contains(station)) {
      return "metro_line_2".tr;
    } else if (metroLine3.contains(station)) {
      return "metro_line_3".tr;
    } else {
      return "cairo_university_branch".tr; // Default case
    }
  }
  // Function to get the distance string based on the value
  String _getDistanceString(double distance) {
    if (distance > 1000) {
      // Convert to kilometers if greater than 1000 meters
      double distanceInKm = distance / 1000; // Convert to km
      return '${distanceInKm.toStringAsFixed(2)} ${'km'.tr}'; // Localize "km"
    } else {
      return '${distance.toStringAsFixed(0)} ${'meters'.tr}'; // Localize "meters"
    }
  }
}
