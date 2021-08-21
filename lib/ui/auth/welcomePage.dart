import 'package:chat/ui/auth/Widget/login_button.dart';
import 'package:chat/ui/auth/Widget/sign_up_button.dart';
import 'package:chat/ui/auth/Widget/welcome_widget.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xfffbb448), Color(0xffe46b10)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const WelcomeTextWidget(const Color(0xffffffff)),
            SizedBox(
              height: 80,
            ),
            LoginButton(),
            SizedBox(
              height: 20,
            ),
            SignUpButton(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
