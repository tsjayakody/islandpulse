import 'package:flutter/material.dart';
import 'package:islandpulse/constants/color_constants.dart';

class IslandpulseTheme {
  // -- light theme defined here
  static ThemeData light() {
    return ThemeData(
      backgroundColor: ColorConstants.defualtBlack,
      primaryColor: ColorConstants.pulseYellow,
      scaffoldBackgroundColor: ColorConstants.pulseYellow,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: ColorConstants.defualtBlack,
          shape: const CircleBorder(),
          elevation: 0,
        ),
      ),
    );
  }

  // -- dark theme defined here
  static ThemeData dark() {
    return ThemeData(
      backgroundColor: ColorConstants.pulseYellow,
      primaryColor: ColorConstants.defualtBlack,
      scaffoldBackgroundColor: ColorConstants.defualtBlack,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: ColorConstants.pulseYellow,
          shape: const CircleBorder(),
          elevation: 0,
        ),
      ),
    );
  }
}
