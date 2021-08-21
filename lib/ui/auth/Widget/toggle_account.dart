import 'package:chat/helpers/app_router.dart';
import 'package:flutter/material.dart';

import '../loginPage.dart';
import '../signup.dart';

class ToggleAccount extends StatelessWidget {
  final String text1;
  final String text2;
  final int page; // 1 go to login - 2 go to register
  const ToggleAccount(this.text1, this.text2, this.page);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$text1',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              if (page == 1) {
                AppRouter.route.replacmentRoute(LoginPage.routeName);
              } else {
                AppRouter.route.replacmentRoute(SignUpPage.routeName);
              }
            },
            child: Text(
              '$text2',
              style: const TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
