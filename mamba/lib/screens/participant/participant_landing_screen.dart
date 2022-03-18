import 'package:flutter/material.dart';

class ParticipantLandingScreen extends StatefulWidget {
  const ParticipantLandingScreen({Key? key}) : super(key: key);
  static String route = '/participant/landing';

  @override
  _ParticipantLandingScreenState createState() => _ParticipantLandingScreenState();
}

class _ParticipantLandingScreenState extends State<ParticipantLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Participant Landing Screen'),
      ),
    );
  }
}
