import 'package:flutter/material.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/widgets/widgets.dart';

class BuildPotrait extends StatelessWidget {
  const BuildPotrait({
    Key? key,
    required this.pageManager,
  }) : super(key: key);

  final PageManager pageManager;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          //*island-pulse logo
          IslandPulseLogo(
            pageManager: pageManager,
            isLandscape: false,
            imageHeight: 0.30,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          //* music player
          IslandPulseMusicPlayer(pageManager: pageManager),
          const Spacer(),
          //* social media buttons
          IslandPulseSocialMediaButtons(
              isLandscape: true, pageManager: pageManager),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
