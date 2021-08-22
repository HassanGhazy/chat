import 'package:chat/ui/auth/Widget/back_button_widget.dart';
import 'package:chat/ui/auth/Widget/bezierContainer.dart';
import 'package:chat/ui/auth/Widget/custom_text_field.dart';
import 'package:chat/ui/auth/Widget/register_and_login_button.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  static const String routeName = "/reset-password";

  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  const SizedBox(height: 50),
                  CustomTextField("Email", textEditingController: _email),
                  const SizedBox(height: 20),
                  RegisterAndLoginButton(
                    email: _email,
                    password: TextEditingController(),
                    firstName: TextEditingController(),
                    lastName: TextEditingController(),
                    country: TextEditingController(),
                    // phoneNumber: TextEditingController(),
                    title: 'Reset Password',
                    action: 3,
                  ),
                ],
              ),
            ),
          ),
          Navigator.canPop(context)
              ? Positioned(top: 40, left: 0, child: BackButtonWidget())
              : Container(),
        ],
      ),
    ));
  }
}
