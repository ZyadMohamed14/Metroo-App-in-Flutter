// Create a card widget for each metro line
import 'package:flutter/material.dart';

import '../../../domain/model/metroo_operation.dart';
import 'package:get/get.dart';
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
            _buildSectionHeader('operatingHours'.tr),
            Text(
              metroOperation.operatingHours,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildSectionHeader('lastTrainDepartures'.tr),
            ...metroOperation.lastTrainDepartures
                .map((departure) => Text(departure))
                .toList(),
            SizedBox(height: 8),
            _buildSectionHeader('intersections'.tr),
            ...metroOperation.intersections
                .map((intersection) => Text(intersection))
                .toList(),
            SizedBox(height: 8),
            _buildSectionHeader('tripTime'.tr),
            Text(metroOperation.tripTime, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            _buildSectionHeader('headway'.tr),
            Text(metroOperation.headway, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            _buildSectionHeader('trainFleetSize'.tr),
            Text(
              '${metroOperation.trainFleetSize} ${'trains'.tr} (${metroOperation.trainUnits} ${'unitsEach'.tr})',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildSectionHeader('maximumSpeed'.tr),
            Text(
                '${metroOperation.maximumSpeed} ${'kmPerHour'.tr}',
                style: TextStyle(fontSize: 16)
            ),
            SizedBox(height: 8),
            _buildSectionHeader('designCapacity'.tr),
            Text(
                '${metroOperation.designCapacity} ${'passengersPerTrain'.tr}',
                style: TextStyle(fontSize: 16)
            ),
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

