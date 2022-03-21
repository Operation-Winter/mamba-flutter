import 'package:flutter/material.dart';
import 'package:mamba/screens/host/host_setup_screen.dart';
import 'package:mamba/screens/participant/participant_setup_screen.dart';
import 'package:mamba/screens/spectator/spectator_setup_screen.dart';
import 'package:mamba/widgets/landing/landing_image_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);
  static String route = '/';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void didTapHostSession() {
    Navigator.pushNamed(context, HostSetupScreen.route);
  }

  void didTapParticipantSession() {
    Navigator.pushNamed(context, ParticipantSetupScreen.route);
  }

  void didTapSpectatorSession() {
    Navigator.pushNamed(context, SpectatorSetupScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            LandingImageButton(
              title: 'HOST A SESSION',
              imageName: 'images/planning_host.png',
              onPressed: didTapHostSession,
            ),
            LandingImageButton(
              title: 'JOIN A SESSION',
              imageName: 'images/planning_join.png',
              onPressed: didTapParticipantSession,
            ),
            LandingImageButton(
              title: 'SPECTATE A SESSION',
              imageName: 'images/planning_spectate.png',
              onPressed: didTapSpectatorSession,
            ),
          ],
        ),
      ),
    );
  }
}
