import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamba/screens/landing_screen.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningEndSessionState extends StatelessWidget {
  final String sessionName;
  final String description;

  const PlanningEndSessionState({
    Key? key,
    required this.sessionName,
    required this.description,
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
                    TitleText(text: sessionName),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 50,
                      ),
                      child: Image.asset('images/error.png'),
                    ),
                    DescriptionText(text: description),
                    const SizedBox(height: 20),
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
