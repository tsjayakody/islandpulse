import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onpressed,
    this.splashRadius = 1.0,
    this.splashColor = Colors.transparent,
    required this.icon,
    this.iconSize,
    this.highlightColor,
    this.focusColor,
  }) : super(key: key);

  final VoidCallback onpressed;
  final double splashRadius;
  final Color splashColor;
  final IconData icon;
  final double? iconSize;
  final Color? highlightColor;
  final Color? focusColor;

  @override
  Widget build(BuildContext context) {
    //* to check screensize

    bool isAndroidTV;
    bool isPhone;

    final double devicePixelRatio = ui.window.devicePixelRatio;
    final ui.Size size = ui.window.physicalSize;
    final double width = size.width;
    final double height = size.height;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isAndroidTV = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isAndroidTV = true;
      isPhone = false;
    } else {
      isAndroidTV = false;
      isPhone = true;
    }

    //* to check theme mode of the app
    var brightness = Theme.of(context).brightness;
    bool isDarkModeOn = brightness == Brightness.dark;

    return isAndroidTV
        // ignore: deprecated_member_use
        ? FlatButton(
            onPressed: onpressed,
            shape: const CircleBorder(),
            //! change the color for light and dark mode based on designer
            focusColor: isDarkModeOn ? Colors.green : Colors.red,
            child: Center(
              child: FaIcon(
                icon,
                color: Theme.of(context).backgroundColor,
                size: iconSize,
              ),
            ),
          )
        : IconButton(
            hoverColor: Colors.red,
            splashRadius: splashRadius,
            splashColor: splashColor,
            highlightColor: highlightColor,
            focusColor: focusColor,
            onPressed: onpressed,
            icon: Icon(
              icon,
              color: Theme.of(context).backgroundColor,
              size: iconSize,
            ),
          );
  }
}
