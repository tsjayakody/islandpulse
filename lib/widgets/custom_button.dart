import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islandpulse/config/config.dart';
import 'package:islandpulse/constants/color_constants.dart';

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
    return ResponsiveAdapter.responsiveadapter()
        // ignore: deprecated_member_use
        ? FlatButton(
            onPressed: onpressed,
            shape: const CircleBorder(),
            focusColor: ThemeIdentifier.themeIdentifier(context)
                ? ColorConstants.androidTVDark
                : ColorConstants.androidTVLight,
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
