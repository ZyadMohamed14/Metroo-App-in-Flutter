import 'package:flutter/material.dart';
import 'package:metroappinflutter/ui/shared_widgets/app_bar.dart';

import '../../../domain/model/station.dart';
import 'widget/stattion_item.dart';
import 'package:get/get.dart';

class StationDetailsScreen extends StatelessWidget {
  final List<Station> stations;

  StationDetailsScreen({required this.stations});

  @override
  Widget build(BuildContext context) {
    print(stations[0].direction);
    return Scaffold(
      appBar: MetroAppBar(title: 'route_details'.tr,),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return StationItem(station: station); // Else, display StationItem1
        },
      ),
    );
  }
}
