import 'package:flutter/material.dart';

import 'package:mamba/ui_constants.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Text(
        text,
        style: titleTextStyle,
      ),
    );
  }
}
