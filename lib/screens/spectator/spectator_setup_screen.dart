import 'package:flutter/material.dart';
import 'package:mamba/models/screen_arguments/spectator_landing_screen_arguments.dart';
import 'package:mamba/screens/spectator/spectator_landing_screen.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class SpectatorSetupScreenArguments {
  final String? sessionCode;
  final String? password;

  SpectatorSetupScreenArguments({
    this.sessionCode,
    this.password,
  });
}

class SpectatorSetupScreen extends StatefulWidget {
  static String route = '/spectator/setup';
  final String? sessionCode;
  final String? password;

  const SpectatorSetupScreen({
    Key? key,
    this.sessionCode,
    this.password,
  }) : super(key: key);

  @override
  _SpectatorSetupScreenState createState() => _SpectatorSetupScreenState();
}

class _SpectatorSetupScreenState extends State<SpectatorSetupScreen> {
  bool validationPassed = false;
  String? sessionCode;
  String? password;

  bool get formIsValid {
    return sessionCode?.isEmpty == false;
  }

  @override
  void initState() {
    super.initState();
    sessionCode = widget.sessionCode;
    password = widget.password;
    validationPassed = formIsValid;
  }

  void sessionCodeChanged(String? newValue) {
    sessionCode = newValue;
    setState(() {
      validationPassed = formIsValid;
    });
  }

  void didTapSpectateSession() {
    if (!validationPassed) return;
    Navigator.pushNamed(
      context,
      SpectatorLandingScreen.route,
      arguments: SpectatorLandingScreenArguments(
        sessionCode: sessionCode!,
        password: password,
      ),
    );
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
                    top: 16,
                    bottom: 8,
                    left: 16,
                    right: 16,
                  ),
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
                                text: 'Spectate a sizing session',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        const DescriptionText(
                            text:
                                'Provide the details necessary spectate a session below'),
                        StyledTextField(
                          placeholder: 'Session code *',
                          input: sessionCode,
                          onChanged: sessionCodeChanged,
                          autofocus: true,
                          enabled: widget.sessionCode == null,
                        ),
                        StyledTextField(
                          placeholder: 'Password (Optional)',
                          input: password,
                          onChanged: (password) {
                            this.password = password;
                          },
                          enabled: widget.password == null,
                        ),
                        const SizedBox(height: 10),
                        RoundedButton(
                          title: 'Spectate session',
                          enabled: validationPassed,
                          onPressed:
                              validationPassed ? didTapSpectateSession : null,
                        )
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
