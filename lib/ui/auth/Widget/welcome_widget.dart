import 'package:flutter/material.dart';

class WelcomeTextWidget extends StatelessWidget {
  final Color color;
  const WelcomeTextWidget(this.color);
  @override
  Widget build(BuildContext context) {
    return Text('Welcome',
        style:
            TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 30));
  }
}
