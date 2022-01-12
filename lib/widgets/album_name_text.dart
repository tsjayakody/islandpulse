import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandpulse/widgets/widgets.dart';

class AlbumNameText extends StatelessWidget {
  const AlbumNameText({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
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
}
