import 'package:flutter/material.dart';

import 'package:mamba/ui_constants.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  const TitleText({Key? key, required this.text, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: titleTextStyle,
        textAlign: textAlign,
      ),
    );
  }
}
