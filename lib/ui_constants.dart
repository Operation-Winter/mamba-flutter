import 'package:flutter/material.dart';

const primaryColor = Color(0xFFA288E3);
const darkPurple = Color(0xFF38023B);
const accentColor = Color(0xFFCEFDFF);
const disabledColor = Color.fromARGB(255, 116, 116, 116);
const inputBackgroundColor = Color.fromARGB(20, 0, 0, 0);
const lightGrayColor = Color.fromARGB(255, 230, 230, 230);
const maxWidth = 1100.0;

const titleTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 20,
);

const descriptionColoredTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 14,
);

const mediumDescriptionTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

const descriptionTextStyle = TextStyle(
  fontSize: 14,
);

const roundedButtonTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const landingImageButtonTextStyleLightMode = TextStyle(
  color: Colors.black,
  fontSize: 18,
);

const landingImageButtonTextStyleDarkMode = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

const errorTextStyle = TextStyle(
  color: Colors.red,
);

bool isDarkMode(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  return brightness == Brightness.dark;
}
