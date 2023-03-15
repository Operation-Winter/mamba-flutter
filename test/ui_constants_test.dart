import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';
import 'package:test/test.dart';

void main() {
  group('Colours', () {
    test('primaryColor', () {
      WidgetsFlutterBinding.ensureInitialized();
      expect(primaryColor, const Color(0xff6953a6));
    });

    test('darkPurple', () {
      expect(darkPurple, const Color(0xFF38023B));
    });

    test('accentColor', () {
      expect(accentColor, const Color(0xFFCEFDFF));
    });

    test('disabledColor', () {
      expect(disabledColor, const Color.fromARGB(255, 116, 116, 116));
    });

    test('inputBackgroundColor', () {
      expect(inputBackgroundColor, const Color.fromARGB(20, 0, 0, 0));
    });
  });
}
