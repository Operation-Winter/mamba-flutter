import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
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

bool _initialUriIsHandled = false;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;

  StreamSubscription? _sub;

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

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        print('got uri: $uri');
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
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
