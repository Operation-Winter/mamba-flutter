import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class StyledIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String tooltip;

  const StyledIconButton({
    Key? key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: primaryColor),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: onPressed,
        color: primaryColor,
        tooltip: tooltip,
        visualDensity: VisualDensity.comfortable,
      ),
    );
  }
}
