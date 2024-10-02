import 'package:flutter/material.dart';
import 'package:metroappinflutter/ui/shared_widgets/app_bar.dart';

import '../../../domain/model/station.dart';
import 'widget/stattion_item.dart';

class StationDetailsScreen extends StatelessWidget {
  final List<Station> stations;

  StationDetailsScreen({required this.stations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetroAppBar(title: 'Route Details',),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
           print('ziko ${station.path}');
          return StationItem(station: station); // Else, display StationItem1
        },
      ),
    );
  }
}
