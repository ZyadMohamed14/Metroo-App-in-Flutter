import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class AddressConfirmationSheet extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController destinationController;
  final Function( String, TextEditingController) getLocationFromAddress;

  const AddressConfirmationSheet({
    Key? key,
    required this.addressController,
    required this.destinationController,
    required this.getLocationFromAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sheet title with icon
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.greenAccent, size: 28), // Location icon
                SizedBox(width: 8),
                Text(
                  'confirm_your_destination_address'.tr,
                  style: GoogleFonts.gowunBatang(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // TextField for address input with icon
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'confirm_address'.tr,
                hintText: 'enter_your_address'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.home, color: Colors.grey), // Home icon for address input
              ),
            ),
            SizedBox(height: 20.0),

            // Confirm and Cancel Buttons with icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.check, color: Colors.white), // Check icon
                  onPressed: () {
                    String address = addressController.text;
                    if (address.isNotEmpty) {
                      getLocationFromAddress(address,addressController);
                      Navigator.pop(context); // Close the bottom sheet
                    } else {
                      Fluttertoast.showToast(
                        msg: "please_provide_an_address".tr,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Confirm button color
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  label: Text(
                    'confirm'.tr,
                    style: GoogleFonts.gowunBatang(fontSize: 16, color: Colors.white),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.close, color: Colors.white), // Close icon
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Cancel button color
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  label: Text(
                    'cancel'.tr,
                    style: GoogleFonts.gowunBatang(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
