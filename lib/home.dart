import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islandpulse/constants/constants.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/service/service_locator.dart';
import 'package:islandpulse/widgets/widgets.dart';

import 'notifier/play_button_notifier.dart';

class Home extends StatefulWidget {
  final toggleCall;
  const Home({Key? key, this.toggleCall}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //* init-state
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
  }

  //* dispose-state
  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  DateTime preBackpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          const snack = SnackBar(
            content: Text(StringConstants.backButtonwarningText),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          getIt<PageManager>().dispose();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                onpressed: widget.toggleCall,
                icon: Icons.bedtime_rounded,
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          systemOverlayStyle:
              Theme.of(context).scaffoldBackgroundColor == Colors.black
                  ? const SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.light,
                      statusBarColor: Colors.transparent,
                    )
                  : const SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.transparent,
                    ),
        ),
        body: OrientationBuilder(builder: (_, orientation) {
          if (orientation == Orientation.portrait) {
            return buildPotrait(context, pageManager);
          } else {
            return buildLandscape(context, pageManager);
          } // else show the landscape one
        }),
      ),
    );
  }

  //* potrait orientation mode
  SafeArea buildPotrait(BuildContext context, PageManager pageManager) {
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
          islandPulseLogo(context, pageManager, 0.30, false),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          //* music player
          islandPulseMusicPlayer(pageManager, context),
          const Spacer(),
          //* social media buttons
          islandPulseSocialMediaButtons(pageManager, false),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  SafeArea buildLandscape(BuildContext context, PageManager pageManager) {
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
              islandPulseLogo(context, pageManager, 0.50, true),

              //* music player
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: islandPulseMusicPlayer(pageManager, context),
              )
            ],
          ),
          //* social media buttons
          islandPulseSocialMediaButtons(pageManager, true),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Row islandPulseSocialMediaButtons(
    PageManager pageManager,
    bool isLandscape,
  ) {
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

  GestureDetector islandPulseMusicPlayer(
      PageManager pageManager, BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) =>
          pageManager.dragControl(details),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          ValueListenableBuilder<String>(
              valueListenable: pageManager.currentSongTitleNotifier,
              builder: (_, value, __) {
                // * album name text widget
                return albumNameText(value, context);
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
            child: ValueListenableBuilder<String>(
                valueListenable: pageManager.currentSongArtistNotifier,
                builder: (_, value, __) {
                  // * song name text widget
                  return songNameText(value, context);
                }),
          ),
          //* song play/pause button
          playPauseButton(pageManager, context),
          //* song skip widget (back and forward album name)
          songBackwardForwardButtons(pageManager, context),
        ],
      ),
    );
  }

  Container songNameText(String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: CustomText(
        text: value,
        textOverflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w200),
        ),
      ),
    );
  }

  Container albumNameText(String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: CustomText(
        text: value,
        textOverflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }

  Padding songBackwardForwardButtons(
      PageManager pageManager, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            onpressed: pageManager.previous,
            icon: FontAwesomeIcons.angleLeft,
            highlightColor: Colors.transparent,
            iconSize: 30,
            focusColor: Colors.transparent,
          ),
          ValueListenableBuilder<String>(
              valueListenable: pageManager.currentRadioTitleNotifier,
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
          CustomButton(
            onpressed: pageManager.next,
            icon: FontAwesomeIcons.angleRight,
            highlightColor: Colors.transparent,
            iconSize: 30,
            focusColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  Padding playPauseButton(PageManager pageManager, BuildContext context) {
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
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(10),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).backgroundColor)),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Stack islandPulseLogo(
    BuildContext context,
    PageManager pageManager,
    double logoImageHeight,
    bool isLandscape,
  ) {
    return Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -6.7,
            bottom: MediaQuery.of(context).size.height *
                (isLandscape ? 0.069 : 0.04),
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
            height: MediaQuery.of(context).size.height * logoImageHeight,
          ),
        ]);
  }
}
