import 'package:flutter/material.dart';
import 'package:metroappinflutter/data/local/cario_lines.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/widget/metro_dropdownmenu.dart';


class CustomDropDown extends StatelessWidget {
  final TextEditingController controller;
  final String title;
//  final String direction;
  final String hint;

  const CustomDropDown({
    Key? key,
    required this.controller,
    required this.title,
   // required this.direction,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        AppDropDownMenu(
          textEditingController: controller,
          title: title,
        //  direction: direction,
          hint: controller.text.isEmpty ? hint : controller.text,
          items: CairoLines.allCairoLines,
          isCitySelected: true,
        ),
      ],
    );
  }
}
