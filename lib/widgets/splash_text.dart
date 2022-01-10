import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandpulse/constants/constants.dart';

class SplashText extends StatelessWidget {
  const SplashText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: RichText(
        text: TextSpan(
          style:
              GoogleFonts.roboto(fontSize: 10.0, fontWeight: FontWeight.w100),
          children: const [
            TextSpan(
              text: StringConstants.devlopedby,
              style: TextStyle(color: ColorConstants.defualtBlack),
            ),
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
    );
  }
}
