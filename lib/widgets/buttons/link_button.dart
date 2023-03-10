import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class LinkButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const LinkButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.link,
            color: isDarkMode(context) ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: linkButtonTextStyle,
          ),
        ],
      ),
    );
  }
}
