import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islandpulse/config/config.dart';
import 'package:islandpulse/constants/constants.dart';
import 'package:islandpulse/home.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/service/service_locator.dart';
import 'package:islandpulse/widgets/widgets.dart';
import 'package:secondsplash/secondsplash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SplashController splashController = SplashController();
  bool isDark = false;

  //* orientation is set to potrait up- only
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    getIt<PageManager>().init();
    onStart();
    Timer(const Duration(seconds: 4), () {
      splashController.close();
    });
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  onStart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(StringConstants.isDark) != null) {
      isDark = sharedPreferences.getBool(StringConstants.isDark)!;
    } else {
      sharedPreferences.setBool(StringConstants.isDark, isDark);
    }
    setState(() {});
  }

  toggleTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(StringConstants.isDark) != null &&
        sharedPreferences.getBool(StringConstants.isDark) == true) {
      isDark = false;
      sharedPreferences.setBool(StringConstants.isDark, isDark);
    } else {
      isDark = true;
      sharedPreferences.setBool(StringConstants.isDark, isDark);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConstants.islandPulse,
        theme: IslandpulseTheme.light(),
        darkTheme: IslandpulseTheme.dark(),
        home: SecondSplash(
          controller: splashController,
          decoration: const BoxDecoration(
            color: ColorConstants.pulseYellow,
          ),
          child: const SecondSplashColumn(),
          next: Home(toggleCall: toggleTheme),
        ),
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
