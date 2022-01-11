import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomElevatedFacebookButton extends StatelessWidget {
  const CustomElevatedFacebookButton({
    Key? key,
    // required this.pageManager,
    required this.icon,
    required this.onpressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onpressed;

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

    return ElevatedButton(
      style: ButtonStyle(
        //! change the color for light and dark mode based on designer
        overlayColor: MaterialStateProperty.all(isAndroidTV
            ? (isDarkModeOn ? Colors.green : Colors.red)
            : Colors.transparent),
      ),
      onPressed: onpressed,
      child: FaIcon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 16.0,
      ),
    );
  }
}
