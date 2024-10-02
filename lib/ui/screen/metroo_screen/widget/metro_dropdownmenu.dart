import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:metroappinflutter/data/local/cario_lines.dart';
import 'package:metroappinflutter/data/local/metroo_app.dart';

class AppDropDownMenu extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isCitySelected;
  final List<SelectedListItem>? items;

  const AppDropDownMenu({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isCitySelected,
    this.items,
    super.key,
  });

  @override
  State<AppDropDownMenu> createState() => _AppDropDownMenuState();
}

class _AppDropDownMenuState extends State<AppDropDownMenu> {
  /// This is the on text changed method which will display when the city text field is tapped.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        selectedItems: (selectedList) {
          for (var item in selectedList) {
            widget.textEditingController.text = item.name;
          }
        },
        isDismissible: true,
        // listItemBuilder: (index) {
        //   // Access the item at the current index
        //   final item = widget.items![index]; // Assuming widget.items is a list of CustomSelectedListItem
        //   final name = item.name;
        //   // Check if the item is a metro station
        //   bool isMetroStation = CairoLines.cairoLine1().contains(item.name) ||
        //       CairoLines.cairoLine2().contains(item.name) ||
        //       CairoLines.cairoLine3().contains(item.name) ||
        //       CairoLines.kitKatCairoUniversityLine.contains(item.name);
        //
        //   // Return the ListTile widget with a metro icon if it's a metro station
        //   return ListTile(
        //     leading: isMetroStation
        //         ? const Icon(Icons.directions_subway, color: Colors.black)
        //         : null,
        //     title: Text(name),
        //   );
        // },
        bottomSheetTitle: Row(
          children: [
            Image.asset(
              'assets/train.png',
              width: 32,
              height: 32,
              // Add color to enhance appearance
            ),
            const SizedBox(width: 8.0),
            Text(
              widget.title,
              style: GoogleFonts.gowunBatang(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        submitButtonChild: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.lightGreen],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Done',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        maxSelectedItems: 3,
        clearButtonChild: Text(
          'Clear',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        data: widget.items ?? [],
        onSelected: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
            }
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     Image.asset(
        //       'assets/train.png',
        //       width: 32,
        //       height: 32,
        //        // Add color to enhance appearance
        //     ),
        //     const SizedBox(width: 8.0),
        //     Text(
        //       "widget.title",
        //       style: GoogleFonts.gowunBatang(
        //         fontWeight: FontWeight.bold,
        //         fontSize: 16,
        //         color: Colors.black, // Enhanced color scheme
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: Colors.greenAccent, // Matching cursor color
          onTap: widget.isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            hintText: widget.hint,
            hintStyle: GoogleFonts.poppins(
              color: Colors.black38,
              fontSize: 14,
            ),
            prefixIcon: Icon(Icons.location_city, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.greenAccent,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.lightGreen,
                width: 2,
              ),
            ),
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.greenAccent,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
