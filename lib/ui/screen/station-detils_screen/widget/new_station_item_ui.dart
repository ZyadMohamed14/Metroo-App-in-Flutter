import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metroappinflutter/helper/extentions.dart';
import '../../../../domain/model/station.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared_widgets/app_bar.dart';
class StationDetailsItem extends StatelessWidget {
  final Station station;
   List<String>transList=[];
  String currentLanguage  = Get.locale!.languageCode;
  StationDetailsItem({super.key, required this.station});

  @override
  Widget build(BuildContext context) {

    String noOfStations='';
    String tiketPrice='';
     transList = station.transList;
     if(currentLanguage=='ar'){
        noOfStations =  station.path.length.toString().toArabicNumbers();
        tiketPrice =   station.ticketPrice.toString().toArabicNumbers();

     }else{
       noOfStations =  station.path.length.toString();
       tiketPrice =   station.ticketPrice.toString();
     }

     print(transList);
    return SafeArea(
      child: Scaffold(
        appBar: MetroAppBar(title: 'route_details'.tr,), // Wrap the content in a Scaffold for proper layout handling
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
                      detailsItem("stations".tr, noOfStations,
                          Icons.train),
                      const SizedBox(width: 10),
                      detailsItem(
                          "time".tr, formatTime(station.time.toInt()), Icons.access_time),
                      const SizedBox(width: 10),
                      detailsItem("price".tr,tiketPrice,
                          Icons.attach_money),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                originDestenationItem(station.start, "from".tr),
                const SizedBox(height: 10),
                originDestenationItem(station.end, "to".tr),
                const SizedBox(height: 10),

                // The station widgets and transition widget
                buildStationWidgets(
                    station, 'stations'.tr),
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
          FittedBox(
            child: Text(
              data,
              style: GoogleFonts.gowunBatang(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
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
      String stationName, int index, int listSize, Color lineColor,) {
    bool isTransitionStation = transList.contains(stationName);
    if (isTransitionStation) stationName = '$stationName (${'transition_station'.tr})';

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
              alignment: currentLanguage=='ar'?Alignment.centerRight:Alignment.centerLeft,
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



}


