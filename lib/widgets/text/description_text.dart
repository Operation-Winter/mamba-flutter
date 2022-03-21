import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 3, 16, 8),
      child: Text(
        text,
        style: descriptionTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
