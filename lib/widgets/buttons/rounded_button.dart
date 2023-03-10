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
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
        disabledBackgroundColor: disabledColor,
        minimumSize: const Size.fromHeight(40),
      ),
      child: Text(
        title,
        style: roundedButtonTextStyle,
      ),
    );
  }
}
