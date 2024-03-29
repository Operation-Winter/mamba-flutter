import 'dart:async';
import 'dart:developer';

import 'package:mamba/models/screen_arguments/host_landing_screen_arguments.dart';
import 'package:mamba/models/screen_arguments/join_landing_screen_arguments.dart';
import 'package:mamba/models/screen_arguments/spectator_landing_screen_arguments.dart';
import 'package:mamba/repositories/local_storage_repository.dart';
import 'package:mamba/screens/other/privacy_policy_screen.dart';
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
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:uuid/uuid.dart';

import 'screens/landing_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late Brightness _brightness;
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  Future<UuidValue?> get _uuid async {
    return await _localStorageRepository.getUuid;
  }

  get _initialRoute {
    return LandingScreen.route;
  }

  get _routes {
    return {
      LandingScreen.route: (context) => const LandingScreen(),
      HostSetupScreen.route: (context) => const HostSetupScreen(),
      PrivacyPolicyScreen.route: (context) => const PrivacyPolicyScreen(),
    };
  }

  @override
  void initState() {
    super.initState();
    usePathUrlStrategy();
    _initDeepLinks();
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.window.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _brightness = WidgetsBinding.instance.window.platformBrightness;
      });
    }

    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
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

  void openAppLink(Uri uri) async {
    if (uri.pathSegments.contains('planning') == true &&
        uri.pathSegments.contains('share') == true) {
      _handleShareURL(uri);
    } else if (uri.path == JoinLandingScreen.route && await _uuid != null) {
      _handleReloadJoinLanding();
    } else if (uri.path == HostLandingScreen.route && await _uuid != null) {
      _handleReloadHostLanding();
    } else if (uri.path == SpectatorLandingScreen.route &&
        await _uuid != null) {
      _handleReloadSpectatorLanding();
    } else {
      await _localStorageRepository.removeUuid();
    }
  }

  _handleReloadJoinLanding() {
    _navigatorKey.currentState?.pushNamed(
      JoinLandingScreen.route,
      arguments: JoinLandingScreenArguments(
        reconnect: true,
      ),
    );
  }

  _handleReloadHostLanding() {
    _navigatorKey.currentState?.pushNamed(
      HostLandingScreen.route,
      arguments: HostLandingScreenArguments(
        reconnect: true,
      ),
    );
  }

  _handleReloadSpectatorLanding() {
    _navigatorKey.currentState?.pushNamed(
      SpectatorLandingScreen.route,
      arguments: SpectatorLandingScreenArguments(
        reconnect: true,
      ),
    );
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
          reconnect: arguments.reconnect,
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
          reconnect: arguments.reconnect,
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
          reconnect: arguments.reconnect,
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

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? IosApp(
            navigatorKey: _navigatorKey,
            initialRoute: _initialRoute,
            routes: _routes,
            onGenerateRoute: onGenerateRoute,
            brightness: _brightness,
          )
        : DefaultApp(
            navigatorKey: _navigatorKey,
            initialRoute: _initialRoute,
            routes: _routes,
            onGenerateRoute: onGenerateRoute,
          );
  }
}

class DefaultApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final Map<String, Widget Function(BuildContext)> routes;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;

  const DefaultApp({
    super.key,
    required this.navigatorKey,
    required this.initialRoute,
    required this.routes,
    required this.onGenerateRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Mamba',
      theme: lightMaterialTheme,
      darkTheme: darkMaterialTheme,
      themeMode: ThemeMode.system,
      initialRoute: initialRoute,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
    );
  }
}

class IosApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final Map<String, Widget Function(BuildContext)> routes;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final Brightness brightness;

  const IosApp({
    super.key,
    required this.navigatorKey,
    required this.initialRoute,
    required this.routes,
    required this.onGenerateRoute,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: cupertinoMaterialTheme,
      child: CupertinoApp(
        navigatorKey: navigatorKey,
        title: 'Mamba',
        theme: cupertinoTheme(brightness),
        initialRoute: initialRoute,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
