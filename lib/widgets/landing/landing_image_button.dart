import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class LandingImageButton extends StatelessWidget {
  final String title;
  final String imageName;
  final VoidCallback? onPressed;

  const LandingImageButton({
    Key? key,
    required this.title,
    required this.imageName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
            ),
          ],
        ),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: Image.asset(
                    imageName,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: isDarkMode(context)
                      ? landingImageButtonTextStyleDarkMode
                      : landingImageButtonTextStyleLightMode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
