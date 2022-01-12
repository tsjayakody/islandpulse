import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/widgets/widgets.dart';

class IslandPulseSocialMediaButtons extends StatelessWidget {
  const IslandPulseSocialMediaButtons({
    Key? key,
    required this.isLandscape,
    required this.pageManager,
  }) : super(key: key);

  final bool isLandscape;
  final PageManager pageManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        isLandscape ? const Spacer() : const SizedBox.shrink(),
        // facebook button
        CustomElevatedFacebookButton(
          icon: FontAwesomeIcons.facebook,
          onpressed: pageManager.launchFacebook,
        ),
        // youtube button
        isLandscape ? const SizedBox(width: 20) : const SizedBox.shrink(),
        CustomElevatedFacebookButton(
          icon: FontAwesomeIcons.youtube,
          onpressed: pageManager.launchYoutube,
        ),
        // instagram button
        isLandscape ? const SizedBox(width: 20) : const SizedBox.shrink(),
        CustomElevatedFacebookButton(
          icon: FontAwesomeIcons.instagram,
          onpressed: pageManager.launchInstagram,
        ),
        isLandscape ? const Spacer() : const SizedBox.shrink(),
      ],
    );
  }
}
