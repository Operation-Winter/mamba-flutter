import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamba/screens/host/host_landing_screen.dart';
import 'package:mamba/screens/host/host_setup_screen.dart';
import 'package:mamba/screens/participant/participant_landing_screen.dart';
import 'package:mamba/screens/participant/participant_setup_screen.dart';
import 'package:mamba/screens/spectator/spectator_landing_screen.dart';
import 'package:mamba/screens/spectator/spectator_setup_screen.dart';
import 'package:mamba/ui_constants.dart';

import 'screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get _initialRoute {
    return LandingScreen.route;
  }

  get _routes {
    return {
      LandingScreen.route: (context) => const LandingScreen(),
      HostSetupScreen.route: (context) => const HostSetupScreen(),
      HostLandingScreen.route: (context) => const HostLandingScreen(),
      ParticipantSetupScreen.route: (context) => const ParticipantSetupScreen(),
      ParticipantLandingScreen.route: (context) =>
          const ParticipantLandingScreen(),
      SpectatorSetupScreen.route: (context) => const SpectatorSetupScreen(),
      SpectatorLandingScreen.route: (context) => const SpectatorLandingScreen(),
    };
  }

  MaterialApp _defaultApp() {
    return MaterialApp(
      title: 'Mamba',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: _initialRoute,
      routes: _routes,
    );
  }

  CupertinoApp _iosApp() {
    return CupertinoApp(
      title: 'Mamba',
      theme: const CupertinoThemeData(
        primaryColor: primaryColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: primaryColor,
        ),
      ),
      initialRoute: _initialRoute,
      routes: _routes,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _iosApp() : _defaultApp();
  }
}
