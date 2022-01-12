import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:islandpulse/config/config.dart';
import 'package:islandpulse/constants/constants.dart';
import 'package:islandpulse/notifier/play_button_notifier.dart';
import 'package:islandpulse/page_manager.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key? key,
    required this.pageManager,
  }) : super(key: key);

  final PageManager pageManager;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<ButtonState>(
              valueListenable: pageManager.playButtonNotifier,
              builder: (_, value, __) {
                switch (value) {
                  case ButtonState.loading:
                    return SpinKitPulse(
                      color: Theme.of(context).backgroundColor,
                      size: 60.0,
                    );
                  case ButtonState.paused:
                    return ElevatedButton(
                      onPressed: pageManager.play,
                      child: Icon(
                        Icons.play_arrow_outlined,
                        size: 55.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              ResponsiveAdapter.responsiveadapter()
                                  ? (ThemeIdentifier.themeIdentifier(context)
                                      ? ColorConstants.androidTVDark
                                      : ColorConstants.androidTVLight)
                                  : Colors.transparent),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(10),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).backgroundColor)),
                    );
                  case ButtonState.playing:
                    return ElevatedButton(
                      onPressed: pageManager.stop,
                      child: Icon(
                        Icons.stop_outlined,
                        size: 55.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            ResponsiveAdapter.responsiveadapter()
                                ? (ThemeIdentifier.themeIdentifier(context)
                                    ? ColorConstants.androidTVDark
                                    : ColorConstants.androidTVLight)
                                : Colors.transparent),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(10),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).backgroundColor),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
