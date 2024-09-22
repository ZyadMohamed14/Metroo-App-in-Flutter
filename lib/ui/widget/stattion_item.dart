import 'package:flutter/material.dart';

import '../../domain/model/station.dart';



class StationItem extends StatelessWidget {
  final Station station;

  StationItem({required this.station});

  @override
  Widget build(BuildContext context) {
    String time ='${station.getTime()} mins';
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRowItem("Start Station", station.getStart()),
            buildRowItem("End Station", station.getEnd()),
            buildRowItem("Time", time),
            buildRowItem("Number of Stations", station.getNoOfStations().toString()),
            buildRowItem("Ticket Price", station.getTicketPrice().toStringAsFixed(2)),
            buildRowItem("Direction", station.getDirection()),
            SizedBox(height: 10,),
            buildRowItem("Path", station.getPath().join(' -> ')),
          ],
        ),
      ),
    );
  }

  Widget buildRowItem(String header, String data) {
    return Row(
      children: [
        Text(
          "$header : ",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 6,
        ),
        Flexible(child: Text(data, style: TextStyle(
    color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal
        )))
      ],
    );
  }
}
