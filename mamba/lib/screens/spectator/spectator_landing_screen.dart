import 'package:flutter/material.dart';

class SpectatorLandingScreen extends StatefulWidget {
  const SpectatorLandingScreen({Key? key}) : super(key: key);
  static String route = '/spectator/landing';

  @override
  _SpectatorLandingScreenState createState() => _SpectatorLandingScreenState();
}

class _SpectatorLandingScreenState extends State<SpectatorLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Spectator Landing Screen'),
      ),
    );
  }
}
