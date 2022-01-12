import 'package:flutter/material.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/widgets/widgets.dart';

class BuildLandscape extends StatelessWidget {
  const BuildLandscape({
    Key? key,
    required this.pageManager,
  }) : super(key: key);

  final PageManager pageManager;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //* row- logo and player
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //*island-pulse logo
              IslandPulseLogo(
                pageManager: pageManager,
                imageHeight: 0.50,
                isLandscape: true,
              ),

              //* music player
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: IslandPulseMusicPlayer(pageManager: pageManager),
              )
            ],
          ),
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
