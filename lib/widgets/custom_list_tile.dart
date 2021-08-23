import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function? function;
  CustomListTile(this.title, this.icon, [this.function]);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title!),
      leading: Icon(icon),
      onTap: () {
        if (function != null) function!();
      },
    );
  }
}
