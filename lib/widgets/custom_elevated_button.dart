import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islandpulse/config/config.dart';
import 'package:islandpulse/constants/color_constants.dart';

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
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
            ResponsiveAdapter.responsiveadapter()
                ? (ThemeIdentifier.themeIdentifier(context)
                    ? ColorConstants.androidTVDark
                    : ColorConstants.androidTVLight)
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
