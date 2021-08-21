import 'package:chat/helpers/app_router.dart';
import 'package:flutter/material.dart';

class CustomDialoug {
  CustomDialoug._();
  static CustomDialoug customDialoug = CustomDialoug._();
  showCustomDialoug(String message, [Function? function]) {
    showDialog(
        context: AppRouter.route.navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  if (function == null) {
                    AppRouter.route.back();
                  } else {
                    function();
                    AppRouter.route.back();
                  }
                },
                child: Text('ok'),
              )
            ],
          );
        });
  }
}
