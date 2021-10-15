import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/service/service_locator.dart';

import 'notifier/play_button_notifier.dart';

class Home extends StatefulWidget {
  final toggleCall;
  const Home({Key? key, this.toggleCall}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: widget.toggleCall,
                    child: Icon(
                      Icons.bedtime_rounded,
                      size: 20.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Stack(
                alignment: Alignment.center,
                fit: StackFit.loose,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: -6.5,
                    bottom: MediaQuery.of(context).size.height * 0.05,
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
                      }
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/logo_svg.svg',
                    color: Theme.of(context).backgroundColor,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) =>
                  pageManager.dragControl(details),
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  ValueListenableBuilder<String>(
                      valueListenable: pageManager.currentSongTitleNotifier,
                      builder: (_, value, __) {
                        return Container(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                    child: ValueListenableBuilder<String>(
                        valueListenable: pageManager.currentSongArtistNotifier,
                        builder: (_, value, __) {
                          return Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
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
                                    size: 70.0,
                                  );
                                case ButtonState.paused:
                                  return ElevatedButton(
                                    onPressed: pageManager.play,
                                    child: Icon(
                                      Icons.play_arrow_outlined,
                                      size: 70.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .backgroundColor)),
                                  );
                                case ButtonState.playing:
                                  return ElevatedButton(
                                    onPressed: pageManager.stop,
                                    child: Icon(
                                      Icons.stop_outlined,
                                      size: 70.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .backgroundColor)),
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder<bool>(
                            valueListenable: pageManager.isFirstSongNotifier,
                            builder: (_, isFirst, __) {
                              return IconButton(
                                onPressed:
                                    (isFirst) ? null : pageManager.previous,
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: FaIcon(
                                  FontAwesomeIcons.angleLeft,
                                  color: Theme.of(context).backgroundColor,
                                  size: 30.0,
                                ),
                              );
                            }),
                        ValueListenableBuilder<String>(
                            valueListenable:
                                pageManager.currentRadioTitleNotifier,
                            builder: (_, value, __) {
                              return Text(
                                value,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 22.0,
                                  ),
                                ),
                              );
                            }),
                        ValueListenableBuilder<bool>(
                            valueListenable: pageManager.isLastSongNotifier,
                            builder: (_, isLast, __) {
                              return IconButton(
                                onPressed: (isLast) ? null : pageManager.next,
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  color: Theme.of(context).backgroundColor,
                                  size: 30.0,
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: pageManager.launchFacebook,
                  child: FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Theme.of(context).primaryColor,
                    size: 16.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: pageManager.launchYoutube,
                  child: FaIcon(
                    FontAwesomeIcons.youtube,
                    color: Theme.of(context).primaryColor,
                    size: 16.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: pageManager.launchInstagram,
                  child: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Theme.of(context).primaryColor,
                    size: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}