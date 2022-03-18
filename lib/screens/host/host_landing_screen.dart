import 'package:flutter/material.dart';

class HostLandingScreen extends StatefulWidget {
  const HostLandingScreen({Key? key}) : super(key: key);
  static String route = '/host/landing';

  @override
  _HostLandingScreenState createState() => _HostLandingScreenState();
}

class _HostLandingScreenState extends State<HostLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Host Landing Screen'),
      ),
    );
  }
}
