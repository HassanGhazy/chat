import 'package:chat/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  HomePage(this.type);
  final String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                if (type == "Email") {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logoutEmail();
                } else if (type == "Google") {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logoutGoogle();
                } else {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logoutFacebook();
                }
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
