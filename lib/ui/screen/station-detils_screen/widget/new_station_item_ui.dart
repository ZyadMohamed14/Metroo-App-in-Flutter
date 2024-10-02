import 'package:flutter/material.dart';
import 'package:metroappinflutter/helper/extentions.dart';

import '../../../../domain/model/station.dart';
import 'package:google_fonts/google_fonts.dart';

class StationDetailsItem extends StatelessWidget {
  final Station station;
  List transList = [];

  StationDetailsItem({super.key, required this.station});

  @override
  Widget build(BuildContext context) {

    transList = extractTransitionStations(station.direction);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Route Details'),
        ), // Wrap the content in a Scaffold for proper layout handling
        body: SingleChildScrollView(
          // Make the Column scrollable
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      detailsItem(" Stations", station.path.length.toString(),
                          Icons.train),
                      const SizedBox(width: 10),
                      detailsItem(
                          "Time", station.time.toString(), Icons.access_time),
                      const SizedBox(width: 10),
                      detailsItem("Price", station.ticketPrice.toString(),
                          Icons.attach_money),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                originDestenationItem(station.start, "From"),
                const SizedBox(height: 10),
                originDestenationItem(station.end, "To"),
                const SizedBox(height: 10),

                // The station widgets and transition widget
                buildStationWidgets(
                    station, "Start Station (${station.end}) Direction"),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailsItem(String header, String data, IconData icon) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.greenAccent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.greenAccent,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              header,
              style: GoogleFonts.gowunBatang(
                color: Colors.black45,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            data,
            style: GoogleFonts.gowunBatang(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget originDestenationItem(String stationName, String dir) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.greenAccent, // Set your desired border color
            width: 2, // Set the border width
          ),
          borderRadius:
              BorderRadius.circular(8), // Optional: Add rounded corners
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(dir,
                      style: GoogleFonts.gowunBatang(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    stationName,
                    style: GoogleFonts.gowunBatang(
                      color: Colors.black45,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }

  Widget buildStationWidgets(Station station, String header) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.greenAccent, // Set your desired border color
          width: 2, // Set the border width
        ),
        borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18, // Set the size of the circle
                backgroundColor: Colors.white, // Green background
                child: Icon(
                  Icons.train, // City icon
                  color: Colors.black,
                ),
              ),
              Text(
                header,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              // Allows ListView to take the size of its children
              physics: const NeverScrollableScrollPhysics(),
              // Prevent scrolling in ListView
              itemCount: station.path.length,
              itemBuilder: (context, index) {
                return stationItem(
                  station.path[index],
                  index,
                  station.path.length,
                  Colors.greenAccent,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget stationItem(
      String stationName, int index, int listSize, Color lineColor) {
    bool isTransitionStation = transList.contains(stationName.normalize());
    if (isTransitionStation) stationName = '$stationName (Transition Station)';

    Color transitionColor = Colors.orange;
    Color displayColor = isTransitionStation ? transitionColor : lineColor;
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 12, // Set the size of the circle
              backgroundColor: displayColor, // Green background
              child: const CircleAvatar(
                radius: 6, // Set the size of the circle
                backgroundColor: Colors.white, // Green background
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            // Route Name Text
            Text(
              stationName,
              style: GoogleFonts.gowunBatang(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ],
        ),
        // Vertical divider if it's not the last item
        if (index != listSize - 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 40, // Set the height of the divider
                width: 8, // Divider thickness
                color: lineColor, // Divider color
              ),
            ),
          ),
      ],
    );
  }

  List<String> extractTransitionStations(String direction) {
    // Split the string by the phrase "Change Direction at"
    List<String> parts = direction.split("Change Direction at");

    // List to store transition stations
    List<String> transitionStations = [];

    // Start from the second part (since the first part is before the first transition)
    for (int i = 1; i < parts.length; i++) {
      // Extract the first word after the split phrase
      String station = parts[i].trim().split(' ')[0];
      transitionStations.add(station);
    }

    return transitionStations;
  }
}


