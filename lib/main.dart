import 'package:flutter/material.dart';
import 'package:mamba/screens/host/host_landing_screen.dart';
import 'package:mamba/screens/host/host_setup_screen.dart';
import 'package:mamba/screens/participant/participant_landing_screen.dart';
import 'package:mamba/screens/participant/participant_setup_screen.dart';
import 'package:mamba/screens/spectator/spectator_landing_screen.dart';
import 'package:mamba/screens/spectator/spectator_setup_screen.dart';

import 'screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mamba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LandingScreen.route,
      routes: {
        LandingScreen.route: (context) => const LandingScreen(),
        HostSetupScreen.route: (context) => const HostSetupScreen(),
        HostLandingScreen.route: (context) => const HostLandingScreen(),
        ParticipantSetupScreen.route: (context) =>
            const ParticipantSetupScreen(),
        ParticipantLandingScreen.route: (context) =>
            const ParticipantLandingScreen(),
        SpectatorSetupScreen.route: (context) => const SpectatorSetupScreen(),
        SpectatorLandingScreen.route: (context) =>
            const SpectatorLandingScreen(),
      },
    );
  }
}
