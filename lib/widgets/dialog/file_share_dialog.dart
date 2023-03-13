import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart';

class FileShareDialog {
  static showFileShare({
    required BuildContext context,
    required String subject,
    required List<XFile> files,
  }) async {
    if (kIsWeb) {
      for (var file in files) {
        await _saveAndLaunchFile(
          bytes: await file.readAsBytes(),
          fileName: file.name,
        );
      }
      return;
    } else {
      final box = context.findRenderObject() as RenderBox?;

      await Share.shareXFiles(
        files,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      ).then((value) => log('Share sheet closed'));
    }
  }

  static Future<void> _saveAndLaunchFile(
      {required List<int> bytes, required String fileName}) async {
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', fileName)
      ..click();
  }
}
