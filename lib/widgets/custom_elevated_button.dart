import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomElevatedFacebookButton extends StatelessWidget {
  const CustomElevatedFacebookButton({
    Key? key,
    // required this.pageManager,
    required this.icon,
    required this.onpressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: FaIcon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 16.0,
      ),
    );
  }
}
