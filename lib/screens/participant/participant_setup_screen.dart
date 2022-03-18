import 'package:flutter/material.dart';

class ParticipantSetupScreen extends StatefulWidget {
  const ParticipantSetupScreen({Key? key}) : super(key: key);
  static String route = '/participant/setup';

  @override
  _ParticipantSetupScreenState createState() => _ParticipantSetupScreenState();
}

class _ParticipantSetupScreenState extends State<ParticipantSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Participant Setup Screen'),
      ),
    );
  }
}
