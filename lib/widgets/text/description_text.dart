import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final bool medium;

  const DescriptionText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.medium = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: medium ? mediumDescriptionTextStyle : descriptionTextStyle,
        textAlign: textAlign,
      ),
    );
  }
}
