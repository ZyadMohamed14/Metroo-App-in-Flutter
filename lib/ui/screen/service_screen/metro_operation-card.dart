// Create a card widget for each metro line
import 'package:flutter/material.dart';

import '../../../domain/model/metroo_operation.dart';

class MetroLineCard extends StatelessWidget {
  final MetroOperation metroOperation;

  MetroLineCard({required this.metroOperation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              metroOperation.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildSectionHeader('Operating Hours:'),
            Text(
              metroOperation.operatingHours,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildSectionHeader('Last Train Departures:'),
            ...metroOperation.lastTrainDepartures
                .map((departure) => Text(departure))
                .toList(),
            SizedBox(height: 8),
            _buildSectionHeader('Intersections:'),
            ...metroOperation.intersections
                .map((intersection) => Text(intersection))
                .toList(),
            SizedBox(height: 8),
            _buildSectionHeader('Trip Time:'),
            Text(metroOperation.tripTime, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            _buildSectionHeader('Headway:'),
            Text(metroOperation.headway, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            _buildSectionHeader('Train Fleet Size:'),
            Text(
              '${metroOperation.trainFleetSize} trains (${metroOperation.trainUnits} units each)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildSectionHeader('Maximum Speed:'),
            Text('${metroOperation.maximumSpeed} km/h', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            _buildSectionHeader('Design Capacity:'),
            Text('${metroOperation.designCapacity} passengers/train', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
