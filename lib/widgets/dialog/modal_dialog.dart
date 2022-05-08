import 'package:flutter/material.dart';
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
      );
    } else {
      showDialog(
        context: context,
        builder: builder,
        barrierDismissible: true,
      );
    }
  }
}
