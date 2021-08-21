import 'package:chat/helpers/app_router.dart';
import 'package:chat/ui/auth/loginPage.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.route.pushNamed(LoginPage.routeName, {});
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }
}
