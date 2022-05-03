import 'package:flutter/material.dart';
import 'package:mamba/screens/join/join_setup_screen.dart';
import 'package:mamba/screens/landing_screen.dart';
import 'package:mamba/screens/spectator/spectator_setup_screen.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/landing/landing_image_button.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningShareScreenArguments {
  final String sessionCode;
  final String? password;

  PlanningShareScreenArguments({
    required this.sessionCode,
    this.password,
  });
}

class PlanningShareScreen extends StatefulWidget {
  static String route = '/planning/share';
  final String sessionCode;
  final String? password;

  const PlanningShareScreen({
    Key? key,
    required this.sessionCode,
    this.password,
  }) : super(key: key);

  @override
  State<PlanningShareScreen> createState() => _PlanningShareScreenState();
}

class _PlanningShareScreenState extends State<PlanningShareScreen> {
  late String sessionCode;
  String? password;

  @override
  void initState() {
    super.initState();
    sessionCode = widget.sessionCode;
    password = widget.password;
  }

  void didTapParticipantSession() {
    Navigator.pushNamed(context, JoinSetupScreen.route);
    // TODO: Pre populate password/session code
  }

  void didTapSpectatorSession() {
    Navigator.pushNamed(context, SpectatorSetupScreen.route);
    // TODO: Pre populate password/session code
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
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.popAndPushNamed(
                                        context, LandingScreen.route);
                                  },
                                  iconSize: 30,
                                  icon: const Icon(Icons.chevron_left),
                                ),
                                const Expanded(
                                  child: TitleText(
                                    text: 'Join a session',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(width: 48),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        LandingImageButton(
                          title: 'Join as a participant',
                          imageName: 'images/planning_join.png',
                          onPressed: didTapParticipantSession,
                        ),
                        LandingImageButton(
                          title: 'Join as a spectator',
                          imageName: 'images/planning_spectate.png',
                          onPressed: didTapSpectatorSession,
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
