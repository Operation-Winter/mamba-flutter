import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mamba/networking/url_center.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PlanningSessionSharingScreen extends StatelessWidget {
  final String sessionCode;
  final String? password;

  const PlanningSessionSharingScreen({
    Key? key,
    required this.sessionCode,
    this.password,
  }) : super(key: key);

  get _urlForSharing =>
      URLCenter.sharePath(sessionCode: sessionCode, password: password);

  _didTapCopyLink(BuildContext context) async =>
      await Clipboard.setData(ClipboardData(text: _urlForSharing.toString()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin:
                const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const TitleText(text: 'Share session'),
                  Text(
                    'Session code: $sessionCode',
                    style: mediumDescriptionTextStyle,
                  ),
                  const SizedBox(height: 16),
                  RoundedButton(
                    title: 'Copy URL',
                    onPressed: () async {
                      await _didTapCopyLink(context);
                    },
                    enabled: true,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: QrImage(
                      data: _urlForSharing.toString(),
                      version: QrVersions.auto,
                      foregroundColor: primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
