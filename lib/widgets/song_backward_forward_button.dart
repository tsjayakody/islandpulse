import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/widgets/widgets.dart';

class SongBackwardForwardButton extends StatelessWidget {
  const SongBackwardForwardButton({
    Key? key,
    required this.pageManager,
  }) : super(key: key);

  final PageManager pageManager;

  @override
  Widget build(BuildContext context) {
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
}
