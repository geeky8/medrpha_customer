import 'dart:ui';

import 'package:flutter/material.dart';

import 'PrefData.dart';
import 'SizeConfig.dart';

class ConstantData {
  //static Color primaryColor = "#07A9F0".toColor();
  static Color primaryColor = Colors.cyan;

  static Color accentColor = "#FF9800".toColor();
  static Color bgColor = "#ffffff".toColor();
  static Color viewColor = "#F1F1F1".toColor();
  static Color cellColor = "#F1F1F1".toColor();
  // static Color cellColor = "#E4E6ED".toColor();
  static String fontFamily = "SFProText";
  // static String assetsPath = "assets/images/";
  static String assetsPath = "assets/myimages/";

  static String dateFormat = "EEE ,MMM dd,yyyy";

  static const double avatarRadius = 40;
  static Color mainTextColor = "#030303".toColor();
  static Color borderColor = Colors.grey.shade400;
  // static Color mainTextColor = "#084043".toColor();
  static Color textColor = "#4E4E4E".toColor();
  static Color color1 = "#FD6C57".toColor();
  static Color color2 = "#019E8B".toColor();
  static Color color3 = "#1F8AFB".toColor();
  static Color color4 = "#FB9754".toColor();
  static Color color5 = "#E66474".toColor();
  static Color cartColor = "#F1F1F1".toColor();
  static const btnFontSize = 15.0;
  static const btnPadding = 15.0;
  static const btnRounding = 10.0;

  static ButtonStyle btnStylePrimary = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: btnFontSize),
    primary: ConstantData.primaryColor,
    padding: EdgeInsets.all(btnPadding),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(btnRounding)),
    ),
    onSurface: Colors.grey,
  );
  static ButtonStyle btnStyleSecondary = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: btnFontSize),
    primary: Colors.cyan,
    padding: EdgeInsets.all(btnPadding),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(btnRounding)),
    ),
    onSurface: Colors.grey,
  );

  static Color shadowColor = ConstantData.primaryColor.withOpacity(0.2);

  static String privacyPolicy = "https://google.com";
  static double font15Px = SizeConfig.safeBlockVertical / 0.6;

  static double font12Px = SizeConfig.safeBlockVertical / 0.75;

  static double font18Px = SizeConfig.safeBlockVertical / 0.5;
  static double font22Px = SizeConfig.safeBlockVertical / 0.4;
  static double font25Px = SizeConfig.safeBlockVertical / 0.3;

  static const double padding = 20;

  static String timeFormat = "hh:mm aa";

  static Color getOrderColor(String s) {
    if (s.contains("On Delivery")) {
      return "#FFEDCE".toColor();
    } else if (s.contains("Completed")) {
      return primaryColor;
    } else {
      return Colors.red;
    }
  }

  static Color getPrescriptionColor(String s) {
    if (s.contains("Submitted")) {
      return accentColor;
    } else if (s.contains("Approved")) {
      return Colors.green;
    } else {
      return Colors.redAccent;
    }
  }

  static Color getIconColor(String s) {
    if (s.contains("On Delivery")) {
      return accentColor;
    } else {
      return Colors.white;
    }
  }

  static colorList() {
    List<Color> colorList = [];
    colorList.add(color1);
    colorList.add(color2);
    colorList.add(color3);
    colorList.add(color4);
    colorList.add(color5);
    return colorList;
  }

  static setThemePosition() async {
    int themMode = await PrefData.getThemeMode();

    print("themeMode-----$themMode");

    if (themMode == 1) {
      textColor = Colors.white70;
      bgColor = "#14181E".toColor();
      viewColor = "#292929".toColor();
      cellColor = "#252525".toColor();
      mainTextColor = Colors.white;
      borderColor = Colors.white70;

      cartColor = "#1E1D26".toColor();
      viewColor = "#1E1D26".toColor();
    } else {
      textColor = "#0A2A2C".toColor();
      bgColor = "#ffffff".toColor();
      viewColor = Colors.grey.shade100;
      cellColor = "#F1F1F1".toColor();
      // mainTextColor = "#084043".toColor();
      mainTextColor = "#030303".toColor();
      borderColor = Colors.grey.shade400;
      cartColor = "#F1F1F1".toColor();
    }
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
