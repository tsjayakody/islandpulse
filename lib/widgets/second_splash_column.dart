import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandpulse/constants/constants.dart';

// TODO: 1 breakdown the widget class

class SecondSplashColumn extends StatelessWidget {
  const SecondSplashColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        // TODO: 2 extract here
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              return Image.asset(
                ImageConstants.lightThemeLogoImage,
                height: MediaQuery.of(context).size.height * 0.3,
              );
            }),
            // TODO: 3 extract here
            const Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: SpinKitThreeBounce(
                size: 30.0,
                color: ColorConstants.defualtBlack,
              ),
            )
          ],
        ),
        // TODO: 4 extract here
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.roboto(
                  fontSize: 10.0, fontWeight: FontWeight.w100),
              children: const [
                // TODO: 6 extract here
                TextSpan(
                  text: StringConstants.devlopedby,
                  style: TextStyle(color: ColorConstants.defualtBlack),
                ),
                // TODO: 7 extract here
                TextSpan(
                  text: StringConstants.deranaMacro,
                  style: TextStyle(
                    color: ColorConstants.defualtRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
