import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:islandpulse/constants/constants.dart';

class SplashLogoImage extends StatelessWidget {
  const SplashLogoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(builder: (context) {
          return Image.asset(
            ImageConstants.lightThemeLogoImage,
            height: MediaQuery.of(context).size.height * 0.3,
          );
        }),
        const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: SpinKitThreeBounce(
            size: 30.0,
            color: ColorConstants.defualtBlack,
          ),
        )
      ],
    );
  }
}
