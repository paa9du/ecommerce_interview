import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimensions {
  static double screenHeight(BuildContext context) {
    return Get.height;
  }

  static double screenWidth(BuildContext context) {
    return Get.width;
  }

  static double pageView(BuildContext context) {
    return screenHeight(context) / 2.78;
  }

  static double pageViewContainer(BuildContext context) {
    return screenHeight(context) / 4.04;
  }

  static double pageViewTextContainer(BuildContext context) {
    return screenHeight(context) / 7.41;
  }

  // dynamic height padding and margin
  static double height10(BuildContext context) {
    return screenHeight(context) / 89.02;
  }

  static double height20(BuildContext context) {
    return screenHeight(context) / 44.51;
  }

  static double height15(BuildContext context) {
    return screenHeight(context) / 59.34;
  }

  static double height30(BuildContext context) {
    return screenHeight(context) / 27.56;
  }

  static double height45(BuildContext context) {
    return screenHeight(context) / 18.37;
  }

  // button height
  static double bottomheightbar(BuildContext context) {
    return screenHeight(context) / 7.4;
  }

  // dynamic width padding and margin
  static double width10(BuildContext context) {
    return screenHeight(context) / 89.02;
  }

  static double width20(BuildContext context) {
    return screenHeight(context) / 44.51;
  }

  static double width15(BuildContext context) {
    return screenHeight(context) / 59.34;
  }

  static double width30(BuildContext context) {
    return screenHeight(context) / 27.56;
  }

  // font sizes
  static double font20(BuildContext context) {
    return screenHeight(context) / 55.12;
  }

  static double font26(BuildContext context) {
    return screenHeight(context) / 34.24;
  }

  static double font16(BuildContext context) {
    return screenHeight(context) / 55.75;
  }

  // radius
  static double radius15(BuildContext context) {
    return screenHeight(context) / 59.34;
  }

  static double radius20(BuildContext context) {
    return screenHeight(context) / 59.34;
  }

  static double radius30(BuildContext context) {
    return screenHeight(context) / 27.56;
  }

  // icons size
  static double iconSize24(BuildContext context) {
    return screenHeight(context) / 34.45;
  }

  static double iconSize16(BuildContext context) {
    return screenHeight(context) / 55.64;
  }

  // list view size
  static double listViewImageSize(BuildContext context) {
    return screenWidth(context) / 3.27;
  }

  static double listViewTextCountSize(BuildContext context) {
    return screenWidth(context) / 3.927;
  }

  // food details
  static double foodImageSize(BuildContext context) {
    return screenWidth(context) / 1.24;
  }

  // splash screen
  static double splashImg(BuildContext context) {
    return screenHeight(context) / 3.40;
  }
}
