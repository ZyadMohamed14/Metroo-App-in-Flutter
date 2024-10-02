import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EnableServiceText extends StatelessWidget {
  final Function() getCurrentLocation;

  const EnableServiceText({super.key, required this.getCurrentLocation});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black, // Default text color
        ),
        children: <TextSpan>[
          const TextSpan(
            text: "For a better experience, ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: "enable your location services.",
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline, // Underline for emphasis
            ),
            recognizer: TapGestureRecognizer()..onTap = ()  {
              getCurrentLocation();
            },
          ),
        ],
      ),
    );
  }
}
