import 'package:universal_io/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/ui_constants.dart';

class TextFieldAlertDialog {
  static CupertinoAlertDialog _iOSInputDialog({
    required String title,
    required String placeholder,
    required String primaryActionTitle,
    required BuildContext context,
    required TextEditingController controller,
    required Function(String) textFieldInput,
  }) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CupertinoTextField(
          placeholder: placeholder,
          controller: controller,
          cursorColor: primaryColor,
          style: TextStyle(
            color: isDarkMode(context) ? Colors.white : Colors.black,
          ),
          autofocus: true,
          onSubmitted: (_) {
            textFieldInput(controller.text);
            controller.clear();
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        CupertinoButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: primaryColor),
          ),
          onPressed: () {
            controller.clear();
            Navigator.of(context).pop();
          },
        ),
        CupertinoButton(
          child: Text(
            primaryActionTitle,
            style: const TextStyle(color: primaryColor),
          ),
          onPressed: () {
            textFieldInput(controller.text);
            controller.clear();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static AlertDialog _androidInputDialog({
    required String title,
    required String placeholder,
    required String primaryActionTitle,
    required BuildContext context,
    required TextEditingController controller,
    required Function(String) textFieldInput,
  }) {
    return AlertDialog(
      title: Text(title),
      content: StyledTextField(
        placeholder: placeholder,
        controller: controller,
        padding: EdgeInsets.zero,
        autofocus: true,
        onFieldSubmitted: () {
          textFieldInput(controller.text);
          controller.clear();
          Navigator.of(context).pop();
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            controller.clear();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(primary: primaryColor),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            textFieldInput(controller.text);
            controller.clear();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(primary: primaryColor),
          child: Text(primaryActionTitle),
        ),
      ],
    );
  }

  static void show({
    required String title,
    required String placeholder,
    required String primaryActionTitle,
    required BuildContext context,
    required TextEditingController controller,
    required Function(String) textFieldInput,
  }) async {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return _iOSInputDialog(
            title: title,
            placeholder: placeholder,
            primaryActionTitle: primaryActionTitle,
            context: context,
            controller: controller,
            textFieldInput: textFieldInput,
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) {
          return _androidInputDialog(
            title: title,
            placeholder: placeholder,
            primaryActionTitle: primaryActionTitle,
            context: context,
            controller: controller,
            textFieldInput: textFieldInput,
          );
        },
      );
    }
  }
}
