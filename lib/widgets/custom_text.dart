import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    required this.textAlign,
    required this.textStyle,
    this.textOverflow,
  }) : super(key: key);

  final String text;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      textAlign: textAlign,
      style: textStyle,
    );
  }
}
