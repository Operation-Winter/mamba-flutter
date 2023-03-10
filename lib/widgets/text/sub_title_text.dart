import 'package:flutter/material.dart';

import 'package:mamba/ui_constants.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  const SubTitleText({Key? key, required this.text, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: titleTextStyle,
        textAlign: textAlign,
      ),
    );
  }
}
