// Define a class to handle the Metro Pricing Bottom Sheet
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            'metroTicketPricing'.tr,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'enterNumberOfStations'.tr,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                numberOfStations = int.parse(value);
                updatePrice();
                setState(() {});
              } else {
                numberOfStations = 1;
                updatePrice();
                setState(() {});
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'numberOfStationsHint'.tr,
            ),
          ),
          SizedBox(height: 16),
          _buildPricingInfo(),
          SizedBox(height: 16),
          Text(
            '${'numberOfTickets'.tr}: $numberOfTickets',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 16),
          Text(
            '${'totalPrice'.tr}: $pricePerTicket ${'pounds'.tr}',
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
        Text('- ${'pricingInfoMoreThan23'.tr}'),
        Text('- ${'pricingInfo17To23'.tr}'),
        Text('- ${'pricingInfo10To16'.tr}'),
        Text('- ${'pricingInfo1To9'.tr}'),
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