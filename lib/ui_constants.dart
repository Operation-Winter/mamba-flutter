import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color get primaryColor {
  Brightness platformBrightness =
      WidgetsBinding.instance.window.platformBrightness;
  switch (platformBrightness) {
    case Brightness.dark:
      return _primaryColorDarkMode;
    case Brightness.light:
      return _primaryColorLightMode;
  }
}

Color get primaryColorSelection {
  Brightness platformBrightness =
      WidgetsBinding.instance.window.platformBrightness;
  switch (platformBrightness) {
    case Brightness.dark:
      return _primaryColorDarkMode;
    case Brightness.light:
      return _primaryColorDarkMode;
  }
}

const _primaryColorDarkMode = Color(0xFFA288E3);
const _primaryColorLightMode = Color(0xFF6953a6);
const darkPurple = Color(0xFF38023B);
const accentColor = Color(0xFFCEFDFF);
const disabledColor = Color.fromARGB(255, 116, 116, 116);
const inputBackgroundColor = Color.fromARGB(20, 0, 0, 0);
const lightGrayColor = Color.fromARGB(255, 230, 230, 230);
const maxWidth = 1100.0;

TextStyle get titleTextStyle => TextStyle(
      color: primaryColor,
      fontSize: 20,
    );

TextStyle get descriptionColoredTextStyle => TextStyle(
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

// #region Link Button Style

TextStyle get linkButtonTextStyle {
  Brightness platformBrightness =
      WidgetsBinding.instance.window.platformBrightness;
  switch (platformBrightness) {
    case Brightness.dark:
      return linkButtonTextStyleDarkMode;
    case Brightness.light:
      return linkButtonTextStyleLightMode;
  }
}

const linkButtonTextStyleDarkMode = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);

const linkButtonTextStyleLightMode = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

// #endregion

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

var lightMaterialTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColorLightMode,
    brightness: Brightness.light,
  ),
);

var darkMaterialTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColorDarkMode,
    brightness: Brightness.dark,
  ),
);

ThemeData get cupertinoMaterialTheme {
  Brightness platformBrightness =
      WidgetsBinding.instance.window.platformBrightness;
  switch (platformBrightness) {
    case Brightness.dark:
      return darkMaterialTheme;
    case Brightness.light:
      return lightMaterialTheme;
  }
}

CupertinoThemeData cupertinoTheme(Brightness brightness) {
  return CupertinoThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
  );
}
