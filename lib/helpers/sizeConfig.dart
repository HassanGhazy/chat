import 'package:flutter/cupertino.dart';

class SizeConfig {
  SizeConfig._();
  static SizeConfig sizeConfig = SizeConfig._();

  double? width;
  double? height;

  void onInit(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    this.width = mediaQuery.width;
    this.height = mediaQuery.height;
  }
}
