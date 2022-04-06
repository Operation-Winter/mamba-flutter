import 'package:flutter/material.dart';
import 'package:mamba/screens/spectator/spectator_landing_screen.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class SpectatorSetupScreen extends StatefulWidget {
  const SpectatorSetupScreen({Key? key}) : super(key: key);
  static String route = '/spectator/setup';

  @override
  _SpectatorSetupScreenState createState() => _SpectatorSetupScreenState();
}

class _SpectatorSetupScreenState extends State<SpectatorSetupScreen> {
  bool validationPassed = false;
  String? sessionCode;
  String? password;

  void sessionCodeChanged(String? newValue) {
    sessionCode = newValue;
    setState(() {
      validationPassed = formIsValid;
    });
  }

  void didTapSpectateSession() {
    Navigator.pushNamed(context, SpectatorLandingScreen.route);
  }

  bool get formIsValid {
    return sessionCode?.isEmpty == false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        const SizedBox(
                          width: 48,
                        ),
                      ],
                    ),
                    const DescriptionText(
                        text:
                            'Provide the details necessary spectate a session below'),
                    StyledTextField(
                      placeholder: 'Session code *',
                      input: sessionCode,
                      onChanged: sessionCodeChanged,
                    ),
                    StyledTextField(
                      placeholder: 'Password (Optional)',
                      input: password,
                      onChanged: (password) {
                        this.password = password;
                      },
                    ),
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
    );
  }
}
