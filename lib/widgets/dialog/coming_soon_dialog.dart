import 'package:universal_io/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class ComingSoonDialog {
  static CupertinoAlertDialog _iOSDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title:
          const Text('This functionality is not yet implemented. Coming soon!'),
      actions: [
        CupertinoButton(
          child: Text(
            'Ok',
            style: TextStyle(color: primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static AlertDialog _androidDialog(BuildContext context) {
    return AlertDialog(
      title:
          const Text('This functionality is not yet implemented. Coming soon!'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Ok'),
        ),
      ],
    );
  }

  static void show(BuildContext context) async {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return _iOSDialog(context);
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) {
          return _androidDialog(context);
        },
      );
    }
  }
}
