import 'package:chat/helpers/app_router.dart';
import 'package:chat/provider/auth_provider.dart';
import 'package:chat/ui/auth/loginPage.dart';
// import 'package:chat/ui/auth/phone_sign_in_page.dart';
import 'package:chat/ui/auth/reset_password_page.dart';
import 'package:chat/ui/auth/signup.dart';
import 'package:chat/ui/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/auth/welcomePage.dart';

void main() => runApp(ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      navigatorKey: AppRouter.route.navKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        LoginPage.routeName: (_) => LoginPage(),
        SignUpPage.routeName: (_) => SignUpPage(),
        HomePage.routeName: (_) => HomePage(""),
        ResetPassword.routeName: (_) => ResetPassword(),
        // PhoneSignInPage.routeName: (_) => PhoneSignInPage(),
      },
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: Text("Something is Wrong"),
                centerTitle: true,
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return WelcomePage();
        },
      ),
    );
  }
}
