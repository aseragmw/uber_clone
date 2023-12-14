import 'package:flutter/material.dart';
import 'package:uber_clone_app/utils/screen_size.dart';

class AppTheme {
  //Colors
  static const Color redColor = Color.fromARGB(255, 226, 41, 28);
  static const Color blackColor = Color(0xff000000);
  static const Color whiteColor = Color(0xffffffff);
  static const Color greyOneColor = Color(0xffF1F2F4);
  static const Color darkBlueColor = Color(0xff262C4D);
  static const Color transparentColor = Colors.transparent;

  //Font Sizes
  // static double fontSize12 = 12;
  // static double fontSize14 = 14;
  // static double fontSize16 = 16;
  // static double fontSize18 = 18;
  // static double fontSize20 = 20;
  // static double fontSize22 = 22;
  // static double fontSize30 = 30;

  static double fontSize12(BuildContext context) {
    return context.screenAspectRatio * 12;
  }
  static double fontSize14(BuildContext context) {
    return context.screenAspectRatio * 14;
  }
  static double fontSize16(BuildContext context) {
    return context.screenAspectRatio * 16;
  }
  static double fontSize18(BuildContext context) {
    return context.screenAspectRatio * 18;
  }
  static double fontSize20(BuildContext context) {
    return context.screenAspectRatio * 20;
  }
  static double fontSize22(BuildContext context) {
    return context.screenAspectRatio * 22;
  }
  static double fontSize30(BuildContext context) {
    return context.screenAspectRatio * 30;
  }

  static double fontSize40 = 40;

  static double fontSize50 = 50;
  static double fontSize72 = 72;

  //Font Weights
  static const FontWeight fontWeight400 = FontWeight.w400;
  static const FontWeight fontWeight500 = FontWeight.w500;
  static const FontWeight fontWeight600 = FontWeight.w600;
  static const FontWeight fontWeight700 = FontWeight.w700;

  //Others
  static const BorderRadius boxRadius = BorderRadius.all(Radius.circular(10));
}
