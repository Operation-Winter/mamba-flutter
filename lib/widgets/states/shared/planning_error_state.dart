import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamba/screens/landing_screen.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningErrorState extends StatelessWidget {
  final String sessionName;
  final String errorCode;
  final String errorDescription;
  final VoidCallback? onTapReconnect;

  const PlanningErrorState({
    Key? key,
    required this.sessionName,
    required this.errorCode,
    required this.errorDescription,
    this.onTapReconnect,
  }) : super(key: key);

  _didTapBackToLanding(BuildContext context) =>
      Navigator.popUntil(context, (route) {
        if (route is CupertinoPageRoute) {
          return route.settings.name == LandingScreen.route;
        } else if (route is MaterialPageRoute) {
          return route.settings.name == LandingScreen.route;
        }
        return false;
      });

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
                  top: 16, bottom: 8, left: 16, right: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(text: 'Session: $sessionName'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 50,
                      ),
                      child: Image.asset('images/error.png'),
                    ),
                    const DescriptionText(
                        text:
                            'The snakes are all hissing in unison! Something went wrong!'),
                    const SizedBox(height: 20),
                    Text(
                      'Error code: $errorCode',
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      errorDescription,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 30),
                    RoundedButton(
                      title: 'Try to reconnect',
                      enabled: true,
                      onPressed: () => onTapReconnect?.call(),
                    ),
                    const SizedBox(height: 8),
                    RoundedButton(
                      title: 'Back to landing',
                      enabled: true,
                      onPressed: () => _didTapBackToLanding(context),
                    ),
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
