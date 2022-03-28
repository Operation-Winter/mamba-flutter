import 'package:flutter/material.dart';

const primaryColor = Color(0xFFA288E3);
const disabledColor = Color.fromARGB(255, 116, 116, 116);
const inputBackgroundColor = Color.fromARGB(20, 0, 0, 0);

const titleTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 20,
);

const descriptionColoredTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 14,
);

const descriptionTextStyle = TextStyle(
  fontSize: 14,
);

const roundedButtonTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

bool isDarkMode(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  return brightness == Brightness.dark;
}