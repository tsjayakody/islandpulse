import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeIdentifier {
  static bool themeIdentifier(BuildContext context) {
    //* to check theme mode of the app
    var brightness = Theme.of(context).brightness;
    bool isDarkModeOn = brightness == Brightness.dark;
    return isDarkModeOn;
  }
}
