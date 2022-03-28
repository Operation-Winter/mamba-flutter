import 'package:flutter/material.dart';
import 'package:mamba/models/host/planning_host_state.dart';
import 'package:mamba/providers/host_planning_session.dart';
import 'package:mamba/widgets/session/session_loading_state.dart';
import 'package:provider/provider.dart';
import 'package:mamba/models/planning_card.dart';

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
  late final HostPlanningSession session;

  HostLandingScreen({
    Key? key,
    required String sessionName,
    String? password,
    List<PlanningCard> availableCards = const [],
    bool automaticallyCompleteVoting = false,
    Set<String> tags = const {},
  }) : super(key: key) {
    session = HostPlanningSession(
      sessionName: sessionName,
      password: password,
      availableCards: availableCards,
      automaticallyCompleteVoting: automaticallyCompleteVoting,
      tags: tags,
    );
  }

  @override
  _HostLandingScreenState createState() => _HostLandingScreenState();
}

class _HostLandingScreenState extends State<HostLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HostPlanningSession>(
      create: (context) => widget.session,
      builder: (context, builder) => WillPopScope(
        onWillPop: () async => false,
        child: _buildState(context),
      ),
    );
  }

  Widget _buildState(BuildContext context) {
    switch (Provider.of<HostPlanningSession>(context).state) {
      case PlanningHostState.error:
        return _errorState(context);
      case PlanningHostState.loading:
        return _loadingState(context);
      case PlanningHostState.noneState:
        return _noneState(context);
      case PlanningHostState.votingState:
        return _votingState(context);
      case PlanningHostState.finishedVotingState:
        return _votingFinishedState(context);
      case PlanningHostState.invalidCommand:
        return _errorState(context);
      case PlanningHostState.coffeeVoting:
        return _coffeeVotingState(context);
      case PlanningHostState.coffeeFinishedVoting:
        return _coffeeVotingFinishedState(context);
    }
  }

  Widget _loadingState(BuildContext context) {
    return const SessionLoadingState();
  }

  Widget _errorState(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Error"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noneState(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("None state"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _votingState(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Voting state"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _votingFinishedState(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Voting finished state"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _coffeeVotingState(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Voting state"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _coffeeVotingFinishedState(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Voting finished state"),
            ],
          ),
        ),
      ),
    );
  }
}
