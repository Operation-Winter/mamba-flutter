import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class IconInfo extends StatelessWidget {
  final IconData icon;
  final String info;

  const IconInfo({Key? key, required this.icon, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isDarkMode(context) ? Colors.white : lightGrayColor,
      ),
      constraints: const BoxConstraints(
        maxWidth: 58,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(children: [
          Icon(
            icon,
            color: primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            info,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ]),
      ),
    );
  }
}
