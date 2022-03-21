import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            GestureDetector(
              child: Image.asset(
                imageName,
                fit: BoxFit.fitWidth,
              ),
              onTap: onPressed,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
