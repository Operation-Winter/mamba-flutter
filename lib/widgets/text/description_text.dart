import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  final bool medium;

  const DescriptionText({
    Key? key,
    required this.text,
    this.medium = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: medium ? mediumDescriptionTextStyle : descriptionTextStyle,
      textAlign: TextAlign.center,
    );
  }
}
