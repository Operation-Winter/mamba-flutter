import 'dart:async';
import 'dart:developer';

import 'package:mamba/models/screen_arguments/host_landing_screen_arguments.dart';
import 'package:mamba/models/screen_arguments/join_landing_screen_arguments.dart';
import 'package:mamba/models/screen_arguments/spectator_landing_screen_arguments.dart';
import 'package:mamba/screens/shared/planning_share_screen.dart';
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
import 'package:app_links/app_links.dart';

import 'screens/landing_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  get _initialRoute {
    return LandingScreen.route;
  }

  get _routes {
    return {
      LandingScreen.route: (context) => const LandingScreen(),
      HostSetupScreen.route: (context) => const HostSetupScreen(),
    };
  }

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      log('getInitialAppLink: $appLink');
      openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      log('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    if (uri.pathSegments.contains('planning') == true &&
        uri.pathSegments.contains('share') == true) {
      _handleShareURL(uri);
    }
  }

  _handleShareURL(Uri? uri) {
    var sessionCode = uri?.queryParameters['sessionCode'];
    var password = uri?.queryParameters['password'];

    if (sessionCode == null) return;
    _navigatorKey.currentState?.pushNamed(
      PlanningShareScreen.route,
      arguments: PlanningShareScreenArguments(
        sessionCode: sessionCode,
        password: password,
      ),
    );
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == HostLandingScreen.route) {
      final arguments = settings.arguments as HostLandingScreenArguments?;
      if (arguments == null) return null;
      return MaterialPageRoute(
        settings: RouteSettings(name: HostLandingScreen.route),
        builder: (_) => HostLandingScreen(
          sessionName: arguments.sessionName,
          automaticallyCompleteVoting: arguments.automaticallyCompleteVoting,
          availableCards: arguments.availableCards,
          password: arguments.password,
        ),
      );
    } else if (settings.name == JoinLandingScreen.route) {
      final arguments = settings.arguments as JoinLandingScreenArguments?;
      if (arguments == null) return null;
      return MaterialPageRoute(
        settings: RouteSettings(name: JoinLandingScreen.route),
        builder: (_) => JoinLandingScreen(
          sessionCode: arguments.sessionCode,
          username: arguments.username,
          password: arguments.password,
        ),
      );
    } else if (settings.name == SpectatorLandingScreen.route) {
      final arguments = settings.arguments as SpectatorLandingScreenArguments?;
      if (arguments == null) return null;
      return MaterialPageRoute(
        settings: RouteSettings(name: SpectatorLandingScreen.route),
        builder: (_) => SpectatorLandingScreen(
          sessionCode: arguments.sessionCode,
          password: arguments.password,
        ),
      );
    } else if (settings.name == PlanningShareScreen.route) {
      final arguments = settings.arguments as PlanningShareScreenArguments?;
      if (arguments == null) return null;
      return MaterialPageRoute(
        settings: RouteSettings(name: PlanningShareScreen.route),
        builder: (_) => PlanningShareScreen(
          sessionCode: arguments.sessionCode,
          password: arguments.password,
        ),
      );
    } else if (settings.name == SpectatorSetupScreen.route) {
      final arguments = settings.arguments as SpectatorSetupScreenArguments?;
      return MaterialPageRoute(
        settings: RouteSettings(name: SpectatorSetupScreen.route),
        builder: (_) => SpectatorSetupScreen(
          sessionCode: arguments?.sessionCode,
          password: arguments?.password,
        ),
      );
    } else if (settings.name == JoinSetupScreen.route) {
      final arguments = settings.arguments as JoinSetupScreenArguments?;
      return MaterialPageRoute(
        settings: RouteSettings(name: JoinSetupScreen.route),
        builder: (_) => JoinSetupScreen(
          sessionCode: arguments?.sessionCode,
          password: arguments?.password,
        ),
      );
    }
    return null;
  }

  MaterialApp _defaultApp() {
    return MaterialApp(
      navigatorKey: _navigatorKey,
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
        WidgetsBinding.instance.window.platformBrightness;
    return Theme(
      data: ThemeData(
        brightness: platformBrightness,
        primaryColor: primaryColor,
      ),
      child: CupertinoApp(
        navigatorKey: _navigatorKey,
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
