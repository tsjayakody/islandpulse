import 'package:flutter/material.dart';
import 'package:islandpulse/widgets/widgets.dart';

class SecondSplashColumn extends StatelessWidget {
  const SecondSplashColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SizedBox(),
        // * splash screen logo image widget
        SplashLogoImage(),
        // * splash screen text widget
        SplashText(),
      ],
    );
  }
}
