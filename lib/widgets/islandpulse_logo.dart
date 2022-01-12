import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandpulse/constants/constants.dart';
import 'package:islandpulse/notifier/play_button_notifier.dart';

import '../page_manager.dart';

class IslandPulseLogo extends StatelessWidget {
  const IslandPulseLogo({
    Key? key,
    required this.pageManager,
    required this.isLandscape,
    required this.imageHeight,
  }) : super(key: key);

  final PageManager pageManager;
  final bool isLandscape;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -6.7,
          bottom:
              MediaQuery.of(context).size.height * (isLandscape ? 0.069 : 0.04),
          child: ValueListenableBuilder<ButtonState>(
            valueListenable: pageManager.playButtonNotifier,
            builder: (_, value, __) {
              switch (value) {
                case ButtonState.playing:
                  return SpinKitPulse(
                    color: Theme.of(context).backgroundColor,
                    size: 20.0,
                  );
                case ButtonState.paused:
                  return const SizedBox(
                    width: 20.0,
                    height: 20.0,
                  );
                case ButtonState.loading:
                  return const SizedBox(
                    width: 20.0,
                    height: 20.0,
                  );
              }
            },
          ),
        ),
        SvgPicture.asset(
          ImageConstants.logoImage,
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height * imageHeight,
        ),
      ],
    );
  }
}
