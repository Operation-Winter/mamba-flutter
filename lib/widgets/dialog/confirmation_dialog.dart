import 'package:universal_io/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class ConfirmationAlertDialog {
  static CupertinoAlertDialog _iOSConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onConfirmation,
  }) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(description),
      ),
      actions: [
        CupertinoButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoButton(
          child: const Text(
            'Confirm',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            onConfirmation();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static AlertDialog _androidConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onConfirmation,
  }) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirmation();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onConfirmation,
  }) async {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return _iOSConfirmationDialog(
            context,
            title: title,
            description: description,
            onConfirmation: onConfirmation,
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) {
          return _androidConfirmationDialog(
            context,
            title: title,
            description: description,
            onConfirmation: onConfirmation,
          );
        },
      );
    }
  }
}
