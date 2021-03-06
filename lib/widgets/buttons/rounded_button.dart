import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool enabled;

  const RoundedButton({
    Key? key,
    this.onPressed,
    required this.title,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: enabled ? primaryColor : disabledColor,
        minimumSize: const Size.fromHeight(40),
      ),
      child: Text(
        title,
        style: roundedButtonTextStyle,
      ),
    );
  }
}
