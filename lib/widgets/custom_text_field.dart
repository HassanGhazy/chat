import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final bool isPassword;
  final bool isEnable;
  final TextEditingController? textEditingController;
  // final TextEditingController? password;
  const CustomTextField(this.title,
      {this.isPassword = false,
      this.isEnable = true,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 10),
          TextField(
            obscureText: isPassword,
            enabled: isEnable,
            controller: textEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }
}
