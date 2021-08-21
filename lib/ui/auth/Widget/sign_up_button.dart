import 'package:chat/helpers/app_router.dart';
import 'package:chat/ui/auth/signup.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.route.pushNamed(SignUpPage.routeName, {});
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
