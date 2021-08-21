import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.keyboard_arrow_left, color: Colors.black),
        label: const Text(
          "Back",
          style: TextStyle(color: Color(0xff000000)),
        ));
  }
}
