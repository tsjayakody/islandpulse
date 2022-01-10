import 'package:flutter/material.dart';

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
    return IconButton(
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
