import 'package:flutter/material.dart';
import 'package:mamba/screens/participant/participant_landing_screen.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class ParticipantSetupScreen extends StatefulWidget {
  const ParticipantSetupScreen({Key? key}) : super(key: key);
  static String route = '/participant/setup';

  @override
  _ParticipantSetupScreenState createState() => _ParticipantSetupScreenState();
}

class _ParticipantSetupScreenState extends State<ParticipantSetupScreen> {
  bool validationPassed = false;
  String? sessionCode;
  String? password;
  String? userName;

  void sessionCodeChanged(String? newValue) {
    sessionCode = newValue;
    setState(() {
      validationPassed = formIsValid;
    });
  }

  void userNameChanged(String? newValue) {
    userName = newValue;
    setState(() {
      validationPassed = formIsValid;
    });
  }

  void didTapJoinSession() {
    Navigator.pushNamed(context, ParticipantLandingScreen.route);
  }

  bool get formIsValid {
    return sessionCode?.isEmpty == false && userName?.isEmpty == false;
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
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                        const SizedBox(
                          width: 48,
                        ),
                      ],
                    ),
                    const DescriptionText(
                        text:
                            'Provide the details necessary join a session below'),
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
                    StyledTextField(
                      placeholder: 'Your name *',
                      input: userName,
                      onChanged: userNameChanged,
                    ),
                    RoundedButton(
                      title: 'Join session',
                      enabled: validationPassed,
                      onPressed: validationPassed ? didTapJoinSession : null,
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
