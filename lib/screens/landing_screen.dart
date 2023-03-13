import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mamba/screens/host/host_setup_screen.dart';
import 'package:mamba/screens/join/join_setup_screen.dart';
import 'package:mamba/screens/other/privacy_policy_screen.dart';
import 'package:mamba/screens/spectator/spectator_setup_screen.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/buttons/link_button.dart';
import 'package:mamba/widgets/landing/landing_image_button.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);
  static String route = '/';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void didTapHostSession() =>
      Navigator.pushNamed(context, HostSetupScreen.route);
  void didTapParticipantSession() =>
      Navigator.pushNamed(context, JoinSetupScreen.route);
  void didTapSpectatorSession() =>
      Navigator.pushNamed(context, SpectatorSetupScreen.route);
  void didTapPrivacyPolicy() =>
      Navigator.pushNamed(context, PrivacyPolicyScreen.route);

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
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Column(
                          children: const [
                            TitleText(
                              text: 'MAMBA',
                              textAlign: TextAlign.center,
                            ),
                            DescriptionText(
                              text:
                                  'Scrum poker is a consensus-based, gamified technique for estimating effort or relative size of development goals in software development',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LandingImageButton(
                          title: 'Host a planning session',
                          imageName: 'images/planning_host.png',
                          onPressed: didTapHostSession,
                        ),
                        LandingImageButton(
                          title: 'Join a planning session',
                          imageName: 'images/planning_join.png',
                          onPressed: didTapParticipantSession,
                        ),
                        LandingImageButton(
                          title: 'Spectate a planning session',
                          imageName: 'images/planning_spectate.png',
                          onPressed: didTapSpectatorSession,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Colors.red,
                              size: 28,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Now includes new functionality that allows users to request and kick off a vote to take a coffee break.\n\nYou can now export a session\'s voting results to a CSV file.',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (kIsWeb) ...[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const TitleText(
                            text: 'Other links',
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              LinkButton(
                                title: "Privacy Policy",
                                onPressed: didTapPrivacyPolicy,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
