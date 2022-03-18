import 'package:flutter/material.dart';

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({Key? key}) : super(key: key);
  static String route = '/host/setup';

  @override
  _HostSetupScreenState createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Host Setup Screen'),
      ),
    );
  }
}
