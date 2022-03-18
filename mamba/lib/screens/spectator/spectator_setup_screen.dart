import 'package:flutter/material.dart';

class SpectatorSetupScreen extends StatefulWidget {
  const SpectatorSetupScreen({Key? key}) : super(key: key);
  static String route = '/spectator/setup';

  @override
  _SpectatorSetupScreenState createState() => _SpectatorSetupScreenState();
}

class _SpectatorSetupScreenState extends State<SpectatorSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Spectator Setup Screen'),
      ),
    );
  }
}
