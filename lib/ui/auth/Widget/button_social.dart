import 'package:flutter/material.dart';

class ButtonSocail extends StatelessWidget {
  final String? text;
  final String? path;

  ButtonSocail({this.text, this.path});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        image: AssetImage(path!),
        height: 35,
      ),
      title: Text(
        text!,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
