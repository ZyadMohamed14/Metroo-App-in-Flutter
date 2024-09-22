import 'package:flutter/material.dart';

import '../../domain/model/station.dart';
import '../widget/stattion_item.dart';

class StationDetailsScreen extends StatelessWidget {
  final List<Station> stations;

  StationDetailsScreen({required this.stations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Details'),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return StationItem(station: station);
        },
      ),
    );
  }
}