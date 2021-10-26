import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandpulse/home.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/service/service_locator.dart';
import 'package:secondsplash/secondsplash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
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
    if (sharedPreferences.getBool("isDark") != null) {
      isDark = sharedPreferences.getBool("isDark")!;
    } else {
      sharedPreferences.setBool("isDark", isDark);
    }
    setState(() {});
  }

  toggleTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("isDark") != null &&
        sharedPreferences.getBool("isDark") == true) {
      isDark = false;
      sharedPreferences.setBool("isDark", isDark);
    } else {
      isDark = true;
      sharedPreferences.setBool("isDark", isDark);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: 'Island Pulse',
      theme: ThemeData(
        backgroundColor: Colors.black,
        primaryColor: const Color.fromARGB(255, 255, 241, 0),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 241, 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: const CircleBorder(),
            elevation: 0,
          ),
        ),
      ),
      darkTheme: ThemeData(
        backgroundColor: const Color.fromARGB(255, 255, 241, 0),
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 255, 241, 0),
            shape: const CircleBorder(),
            elevation: 0,
          ),
        ),
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarColor:
              isDark ? Colors.black : const Color.fromARGB(255, 255, 241, 0),
          systemNavigationBarIconBrightness:
              isDark ? Brightness.light : Brightness.dark,
        ),
        child: SecondSplash(
          controller: splashController,
          decoration: BoxDecoration(
            color:
                isDark ? Colors.black : const Color.fromARGB(255, 255, 241, 0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    return Image.asset(
                      isDark
                          ? 'assets/dark_theme_logo.png'
                          : 'assets/light_theme_logo.png',
                      height: MediaQuery.of(context).size.height * 0.3,
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SpinKitThreeBounce(
                      size: 30.0,
                      color: isDark
                          ? const Color.fromARGB(255, 255, 241, 0)
                          : Colors.black,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.roboto(
                        fontSize: 10.0, fontWeight: FontWeight.w100),
                    children: [
                      TextSpan(
                        text: 'Developed by ',
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black),
                      ),
                      const TextSpan(
                        text: 'Derana Macroentertainment (Pvt) Ltd',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          next: Home(toggleCall: toggleTheme),
        ),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
