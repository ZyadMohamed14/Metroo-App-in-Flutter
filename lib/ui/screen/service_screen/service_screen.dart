// Placeholder for the History page content
import 'package:flutter/material.dart';
import '../../../domain/model/metroo_operation.dart';
import 'metro_operation-card.dart';
import 'metro_pricing_bottmsheet.dart';
import 'package:get/get.dart';
// Placeholder for the Historical Places page content
class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('service'.tr),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildServiceCard(
              context,
              title: 'metro_operation'.tr,
              icon: Icons.train,
              gradientColors: [Colors.blue, Colors.blueAccent],
              onPressed: () {
                showMetroLines(context); // Call to show the metro lines
              },
            ),
            const SizedBox(height: 20),
            _buildServiceCard(
              context,
              title: 'metro_pricing'.tr,
              icon: Icons.attach_money,
              gradientColors: [Colors.green, Colors.greenAccent],
              onPressed: () {
                showMetroPricing(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, {
    required String title,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onPressed,
  }) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 30, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white), // Arrow icon to indicate navigation
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showMetroLines(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: MetroOperation.cairoMetroOperations.length,
            itemBuilder: (context, index) {
              return MetroLineCard(metroOperation: MetroOperation.cairoMetroOperations[index]);
            },
          ),
        );
      },
    );
  }


}