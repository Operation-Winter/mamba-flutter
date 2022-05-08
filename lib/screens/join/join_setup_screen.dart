import 'package:flutter/material.dart';
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
  _JoinSetupScreenState createState() => _JoinSetupScreenState();
}

class _JoinSetupScreenState extends State<JoinSetupScreen> {
  bool validationPassed = false;
  String? sessionCode;
  String? password;
  String? username;

  bool get formIsValid {
    return sessionCode?.isEmpty == false && username?.isEmpty == false;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      sessionCode = widget.sessionCode;
      password = widget.password;
    });
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

  void didTapJoinSession() {
    if (sessionCode == null || username == null) return;

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
                          input: username,
                          onChanged: userNameChanged,
                        ),
                        const SizedBox(height: 10),
                        RoundedButton(
                          title: 'Join session',
                          enabled: validationPassed,
                          onPressed:
                              validationPassed ? didTapJoinSession : null,
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
