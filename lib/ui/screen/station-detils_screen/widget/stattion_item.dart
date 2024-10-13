import 'package:flutter/material.dart';
import 'package:metroappinflutter/domain/model/station.dart';
import 'package:metroappinflutter/helper/extentions.dart';

import '../../../../data/local/station_database.dart';
import 'new_station_item_ui.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StationItem extends StatelessWidget {
  final Station station;

  StationItem({required this.station});

  @override
  Widget build(BuildContext context) {

    String time = formatTime(station.getTime().toInt());
    // Determine the text direction
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section with origin and destination
                buildRowItem(
                  icon: Icons.location_on,
                  header: "origin".tr,
                  data: station.getStart(),
                ),
                buildRowItem(
                  icon: Icons.flag,
                  header: "destination".tr,
                  data: station.getEnd(),
                ),
                const Divider(), // Divider for clarity

                // Time and number of stations
                buildRowItem(
                  icon: Icons.access_time,
                  header: 'time'.tr,
                  data: time,
                  textColor: Colors.green, // Highlighted
                ),
                buildRowItem(
                  icon: Icons.directions_subway,
                  header: "number_of_stations".tr,
                  data: station.getNoOfStations().toString(),
                ),
                const Divider(),

                // Ticket price and direction
                buildRowItem(
                  icon: Icons.attach_money,
                  header: 'ticket_price'.tr,
                  data: "\$${station.getTicketPrice().toStringAsFixed(2)}",
                  textColor: Colors.green, // Highlighted
                ),
                buildRowItem(
                  icon: Icons.navigation,
                  header: 'direction'.tr,
                  data: station.getDirection(),
                ),
                const SizedBox(height: 10),

                // Button to view route details
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StationDetailsItem(station: station),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Rounded button
                      ),
                    ),
                    child:  Text(
                      'view_route_details'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned save icon
          Positioned(
            left: isRtl ? 16 : null,
            right: isRtl ? null : 16,
            child: IconButton(
              icon: const Icon(Icons.save, color: Colors.green), // Save icon
              onPressed: () async {
                await saveStation(station); // Save station logic

              },
            ),
          ),
        ],
      ),
    );
  }
  Future<void> saveStation(Station station) async {
    final dbHelper = StationDatabaseHelper(); // Create an instance of your DB helper

    try {
      await dbHelper.insertStation(station); // Insert station into the database
      Fluttertoast.showToast(
        msg: 'route_saved_successfully'.tr, // Toast message
        toastLength: Toast.LENGTH_SHORT, // Duration
        gravity: ToastGravity.BOTTOM, // Position
        timeInSecForIosWeb: 1, // Duration for iOS web
        backgroundColor: Colors.green, // Background color
        textColor: Colors.white, // Text color
        fontSize: 16.0, // Font size
      );
    } catch (e) {

      Fluttertoast.showToast(
        msg: 'failed_to_save_route'.tr, // Error message
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

}

Widget buildRowItem({
  required IconData icon,
  required String header,
  required String data,
  Color textColor = Colors.black,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, color: textColor, size: 20), // Use an icon
        const SizedBox(width: 8),
        Text(
          "$header: ",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            data,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}



