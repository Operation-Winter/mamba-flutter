import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class LargeIconButton extends StatelessWidget {
  final bool highlighted;
  final IconData icon;
  final VoidCallback? onTap;
  final String toolTip;
  final EdgeInsets padding;
  final int? overlayCount;

  const LargeIconButton({
    super.key,
    required this.highlighted,
    required this.icon,
    required this.toolTip,
    this.padding = const EdgeInsets.all(40),
    this.onTap,
    this.overlayCount,
  });

  @override
  Widget build(BuildContext context) {
    var backgroundColor =
        isDarkMode(context) ? primaryColor : Colors.grey.withOpacity(0.6);

    return Tooltip(
      verticalOffset: 70,
      message: toolTip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: padding,
          decoration: BoxDecoration(
            color: highlighted ? backgroundColor : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: isDarkMode(context) ? lightGrayColor : primaryColor,
            size: 70,
          ),
        ),
      ),
    );
  }
}
