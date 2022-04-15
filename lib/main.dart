import 'package:universal_io/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamba/screens/host/host_landing_screen.dart';
import 'package:mamba/screens/host/host_setup_screen.dart';
import 'package:mamba/screens/join/join_landing_screen.dart';
import 'package:mamba/screens/join/join_setup_screen.dart';
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
      JoinSetupScreen.route: (context) => const JoinSetupScreen(),
      SpectatorSetupScreen.route: (context) => const SpectatorSetupScreen(),
      SpectatorLandingScreen.route: (context) => const SpectatorLandingScreen(),
    };
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == HostLandingScreen.route) {
      final arguments = settings.arguments as HostLandingScreenArguments;
      return MaterialPageRoute(
        settings: RouteSettings(name: HostLandingScreen.route),
        builder: (_) => HostLandingScreen(
          sessionName: arguments.sessionName,
          automaticallyCompleteVoting: arguments.automaticallyCompleteVoting,
          availableCards: arguments.availableCards,
          password: arguments.password,
          tags: arguments.tags,
        ),
      );
    } else if (settings.name == JoinLandingScreen.route) {
      final arguments = settings.arguments as JoinLandingScreenArguments;
      return MaterialPageRoute(
        settings: RouteSettings(name: JoinLandingScreen.route),
        builder: (_) => JoinLandingScreen(
          sessionCode: arguments.sessionCode,
          username: arguments.username,
          password: arguments.password,
        ),
      );
    }
    return null;
  }

  MaterialApp _defaultApp() {
    return MaterialApp(
      title: 'Mamba',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: _initialRoute,
      routes: _routes,
      onGenerateRoute: onGenerateRoute,
    );
  }

  Widget _iosApp(BuildContext context) {
    final Brightness platformBrightness =
        WidgetsBinding.instance!.window.platformBrightness;
    return Theme(
      data: ThemeData(
        brightness: platformBrightness,
        primaryColor: primaryColor,
      ),
      child: CupertinoApp(
        title: 'Mamba',
        theme: CupertinoThemeData(
            brightness: platformBrightness, primaryColor: primaryColor),
        initialRoute: _initialRoute,
        routes: _routes,
        onGenerateRoute: onGenerateRoute,
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _iosApp(context) : _defaultApp();
  }
}
