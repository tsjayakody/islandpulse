import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islandpulse/constants/constants.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/service/service_locator.dart';
import 'package:islandpulse/widgets/widgets.dart';

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
            return BuildPotrait(pageManager: pageManager);
          } else {
            return BuildLandscape(pageManager: pageManager);
          } // else show the landscape one
        }),
      ),
    );
  }
}
