import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metroappinflutter/data/local/cario_lines.dart';
import 'package:metroappinflutter/ui/shared_widgets/app_button.dart';



class NearestStationDetails extends StatelessWidget {
  final String nearestStation;
  final double shortestDistance;

  const NearestStationDetails({
    super.key,
    required this.nearestStation,
    required this.shortestDistance,
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
          _buildHeader(),
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
              label: 'Show on Map',
              onPressed: () {
                print("Show on Map pressed for: $nearestStation");
              },
              isLarge: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      "Nearest Station",
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
    double distanceInKm = shortestDistance / 1000; // Convert to km

    return Row(
      children: [
        const Icon(
          Icons.directions_run, // Runner icon
          color: Colors.blue,
          size: 24.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          "${distanceInKm.toStringAsFixed(2)} km away", // Show distance in km
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
    var transitionStation = CairoLines.transitionStation;
    var metroLine1 = CairoLines.cairoLine1();
    var metroLine2 = CairoLines.cairoLine2();
    var metroLine3 = CairoLines.cairoLine3();

    if (transitionStation.containsKey(station)) {
      return transitionStation[station]!; // Access value directly using the key
    } else if (metroLine1.contains(station)) {
      return "Metro Line 1";
    } else if (metroLine2.contains(station)) {
      return "Metro Line 2";
    } else if (metroLine3.contains(station)) {
      return "Metro Line 3";
    } else {
      return "Cairo University Branch"; // Default case
    }
  }
}

