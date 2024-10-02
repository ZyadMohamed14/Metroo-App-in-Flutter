// Placeholder for the History page content
import 'package:flutter/material.dart';
import 'package:metroappinflutter/data/local/station_database.dart';
import 'package:metroappinflutter/data/local/station_entity.dart';

import '../station-detils_screen/widget/stattion_item.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StationEntity>>(
      future: StationDatabaseHelper().getStations(),
      // Fetch stations from the database
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}')); // Show error message
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('No saved stations found.')); // No data message
        } else {
          final stations = snapshot.data!; // Get the list of stations
          return ListView.builder(
            itemCount: stations.length,
            itemBuilder: (context, index) {
              final station = stations[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Use Expanded for the text to ensure it doesn't overflow
                          Expanded(
                            child: Text(
                              '${station.start} to ${station.end}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Avoid text overflow
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Add some spacing
                          ElevatedButton.icon(
                            onPressed: () {
                              // Action when 'View Details' is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            icon: const Icon(
                                Icons.info, color: Colors.white, size: 16),
                            label: const Text(
                              'View Details',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Use buildRowItem method for the rows

                      buildRowItem(
                        icon: Icons.access_time,
                        header: 'Time',
                        data: '${station.time} mins',
                        textColor: Colors.grey[700]!,
                      ),
                      buildRowItem(
                        icon: Icons.train,
                        header: 'No. of Stations',
                        data: '${station.noOfStations}',
                        textColor: Colors.grey[700]!,
                      ),
                      buildRowItem(
                        icon: Icons.attach_money,
                        header: 'Price',
                        data: '\$${station.ticketPrice}',
                        textColor: Colors.green[700]!,
                      ),
                      buildRowItem(
                        icon: Icons.navigation,
                        header: 'Direction',
                        data: station.direction,
                        textColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}