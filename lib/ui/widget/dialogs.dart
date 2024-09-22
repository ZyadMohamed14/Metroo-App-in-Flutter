import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void LoadingDialog(BuildContext context) {
  // Show progress dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Calculating nearest station..."),
            ],
          ),
        ),
      );
    },
  );
}
typedef OpenMapCallback = void Function(BuildContext context);

void showSuccsessDialog(
    BuildContext context,
    TextEditingController controller,
OpenMapCallback openMapCallback,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Nearst Station According To Your Location is ${controller.text}"),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    openMapCallback(context);
                  },
                  child: Text("Show on Map"),
                ),
              ),
            ]

          ),
        ),
      );
    },
  );
}

Future showErrorDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Location Error'),
      content: Text("Faild To get Placese"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
