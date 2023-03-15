import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mamba/ui_constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universal_io/io.dart';

class ModalDialog {
  static showModalBottomSheet({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) {
    if (Platform.isIOS) {
      showBarModalBottomSheet(
        expand: true,
        context: context,
        builder: builder,
        overlayStyle: isDarkMode(context)
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        backgroundColor:
            isDarkMode(context) ? const Color(0xFF1c1b1e) : Colors.white,
      );
    } else if (Platform.isAndroid) {
      showMaterialModalBottomSheet(
        expand: true,
        context: context,
        builder: builder,
      );
    } else {
      showDialog(
        context: context,
        builder: builder,
        barrierDismissible: true,
        useSafeArea: true,
      );
    }
  }
}
