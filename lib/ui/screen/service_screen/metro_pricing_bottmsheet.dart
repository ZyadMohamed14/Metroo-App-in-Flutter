// Define a class to handle the Metro Pricing Bottom Sheet
import 'package:flutter/material.dart';

class MetroPricingBottomSheet extends StatefulWidget {
  @override
  _MetroPricingBottomSheetState createState() => _MetroPricingBottomSheetState();
}

class _MetroPricingBottomSheetState extends State<MetroPricingBottomSheet> {
  int numberOfStations = 1; // Initial number of stations
  int numberOfTickets = 1; // Initial number of tickets
  int pricePerTicket = 8; // Initial price for 1-9 stations

  void updatePrice() {
    if (numberOfStations > 23) {
      pricePerTicket = 20;
    } else if (numberOfStations >= 17) {
      pricePerTicket = 15;
    } else if (numberOfStations >= 10) {
      pricePerTicket = 10;
    } else {
      pricePerTicket = 8;
    }

    // Update the number of tickets based on the number of stations
    numberOfTickets = numberOfStations; // Assuming one ticket per station

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Metro Ticket Pricing',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Enter the number of stations:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                numberOfStations = int.parse(value);
                updatePrice(); // Update price when the number of stations changes
                setState(() {}); // Update the UI
              }else{
                numberOfStations=1;
                updatePrice(); // Update price when the number of stations changes
                setState(() {}); // Update the UI
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Number of Stations',
            ),
          ),
          SizedBox(height: 16),
          _buildPricingInfo(),
          SizedBox(height: 16),
          Text(
            'Number of Tickets: $numberOfTickets',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16),
          Text(
            'Total Price: ${pricePerTicket} pounds',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('- More than 23 stations: 20 pounds.'),
        Text('- From 17 to 23 stations: 15 pounds .'),
        Text('- From 10 to 16 stations: 10 pounds .'),
        Text('- Metro ticket price from one station to 9 stations: 8 pounds .'),
      ],
    );
  }
}

// Show the bottom sheet when Metro Pricing card is tapped
void showMetroPricing(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return MetroPricingBottomSheet();
    },
  );
}