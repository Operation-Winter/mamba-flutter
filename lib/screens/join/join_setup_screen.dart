import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mamba/models/screen_arguments/join_landing_screen_arguments.dart';
import 'package:mamba/repositories/local_storage_repository.dart';
import 'package:mamba/screens/join/join_landing_screen.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class JoinSetupScreenArguments {
  final String? sessionCode;
  final String? password;

  JoinSetupScreenArguments({
    this.sessionCode,
    this.password,
  });
}

class JoinSetupScreen extends StatefulWidget {
  static String route = '/join/setup';
  final String? sessionCode;
  final String? password;

  const JoinSetupScreen({
    Key? key,
    this.sessionCode,
    this.password,
  }) : super(key: key);

  @override
  State<JoinSetupScreen> createState() => _JoinSetupScreenState();
}

class _JoinSetupScreenState extends State<JoinSetupScreen> {
  bool validationPassed = false;
  String? sessionCode;
  String? password;
  String? username;
  final _localStorageRepository = LocalStorageRepository();
  late TextEditingController _usernameController;

  bool get formIsValid {
    return sessionCode?.isEmpty == false && username?.isEmpty == false;
  }

  Future<String?> get getStoredUsername async {
    return await _localStorageRepository.getUsername;
  }

  @override
  void initState() {
    super.initState();
    configureUsername();
    sessionCode = widget.sessionCode;
    password = widget.password;
    _usernameController = TextEditingController();
  }

  Future<void> configureUsername() async {
    username = await getStoredUsername;

    if (username == null) return;
    _usernameController.text = username!;
    setState(() {
      validationPassed = formIsValid;
    });

    if (widget.sessionCode != null && username != null) {
      _didTapJoinSession();
    }
  }

  void sessionCodeChanged(String? newValue) {
    sessionCode = newValue;
    setState(() {
      validationPassed = formIsValid;
    });
  }

  void userNameChanged(String? newValue) {
    username = newValue;
    setState(() {
      validationPassed = formIsValid;
    });
  }

  void passwordChanged(String? newValue) {
    password = newValue;
    setState(() {
      validationPassed = formIsValid;
    });
  }

  void _didTapJoinSession() {
    if (!validationPassed) return;

    Navigator.pushNamed(
      context,
      JoinLandingScreen.route,
      arguments: JoinLandingScreenArguments(
        sessionCode: sessionCode!,
        username: username!,
        password: password,
      ),
    );
  }

  _didTapScanQrCode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      Colors.white.toString(),
      'Cancel',
      false,
      ScanMode.QR,
    );
    var uri = Uri.parse(barcodeScanResult);
    log(barcodeScanResult);
    var sessionCode = uri.queryParameters['sessionCode'];
    var password = uri.queryParameters['password'];
    sessionCodeChanged(sessionCode);
    passwordChanged(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: maxWidth),
            child: ListView(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                      top: 16, bottom: 8, left: 16, right: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: 30,
                              icon: const Icon(Icons.chevron_left),
                            ),
                            const Expanded(
                              child: TitleText(
                                text: 'Join a sizing session',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        const DescriptionText(
                            text:
                                'Provide the details necessary join a session below'),
                        StyledTextField(
                          placeholder: 'Session code *',
                          input: sessionCode,
                          onChanged: sessionCodeChanged,
                          autofocus: widget.sessionCode == null,
                          enabled: widget.sessionCode == null,
                        ),
                        StyledTextField(
                          placeholder: 'Password (Optional)',
                          input: password,
                          onChanged: passwordChanged,
                          enabled: widget.password == null,
                        ),
                        StyledTextField(
                          placeholder: 'Your name *',
                          onChanged: userNameChanged,
                          controller: _usernameController,
                          autofocus: widget.sessionCode != null,
                        ),
                        const SizedBox(height: 10),
                        if (!kIsWeb)
                          RoundedButton(
                            title: 'Scan QR code',
                            enabled: true,
                            onPressed: _didTapScanQrCode,
                          ),
                        RoundedButton(
                          title: 'Join session',
                          enabled: validationPassed,
                          onPressed: _didTapJoinSession,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
