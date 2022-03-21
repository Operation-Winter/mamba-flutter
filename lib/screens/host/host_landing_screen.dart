import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mamba/ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/providers/planning_session.dart';

class HostLandingScreenArguments {
  final String sessionName;
  final String? password;
  final List<PlanningCard> availableCards;
  final bool automaticallyCompleteVoting;
  final Set<String> tags;

  HostLandingScreenArguments({
    required this.sessionName,
    this.password,
    this.availableCards = const [],
    this.automaticallyCompleteVoting = false,
    this.tags = const {},
  });
}

class HostLandingScreen extends StatefulWidget {
  static String route = '/host/landing';
  final String sessionName;
  final String? password;
  final List<PlanningCard> availableCards;
  final bool automaticallyCompleteVoting;
  final Set<String> tags;

  const HostLandingScreen({
    Key? key,
    required this.sessionName,
    this.password,
    this.availableCards = const [],
    this.automaticallyCompleteVoting = false,
    this.tags = const {},
  }) : super(key: key);

  @override
  _HostLandingScreenState createState() => _HostLandingScreenState();
}

class _HostLandingScreenState extends State<HostLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlanningSession>(
      create: (context) => PlanningSession(sessionName: widget.sessionName),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text(widget.sessionName),
                  const SpinKitSpinningLines(
                    color: primaryColor,
                    size: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
