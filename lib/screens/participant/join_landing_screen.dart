import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamba/bloc/join/join_landing_session_bloc.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/states/host/planning_host_none_state.dart';
import 'package:mamba/widgets/states/host/planning_host_voting_finished_state.dart';
import 'package:mamba/widgets/states/host/planning_host_voting_state.dart';
import 'package:mamba/widgets/states/shared/planning_coffee_voting_finished_state.dart';
import 'package:mamba/widgets/states/shared/planning_coffee_voting_state.dart';
import 'package:mamba/widgets/states/shared/planning_end_session_state.dart';
import 'package:mamba/widgets/states/shared/planning_error_state.dart';
import 'package:mamba/widgets/states/shared/planning_loading_state.dart';

class JoinLandingScreenArguments {
  final String sessionCode;
  final String? password;
  final String username;

  JoinLandingScreenArguments({
    required this.sessionCode,
    this.password,
    required this.username,
  });
}

class JoinLandingScreen extends StatefulWidget {
  static String route = '/join/landing';
  late final JoinLandingSessionBloc session;

  JoinLandingScreen({
    Key? key,
    required String sessionCode,
    String? password,
    required String username,
  }) : super(key: key) {
    session = JoinLandingSessionBloc(
      sessionCode: sessionCode,
      password: password,
      username: username,
    );
  }

  @override
  _JoinLandingScreenState createState() => _JoinLandingScreenState();
}

class _JoinLandingScreenState extends State<JoinLandingScreen> {
  @override
  void initState() {
    super.initState();
    _connect();
  }

  Future<void> _connect() async {
    await widget.session.connect();
    widget.session.add(JoinSendJoinSession());
  }

  _didTapRequestCoffee() => print('Did tap request coffee');

  _didTapShare() => print('Did tap share');

  _didTapReconnect() => print('Did tap reconnect');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: maxWidth),
            child: BlocProvider(
              create: (context) => widget.session,
              child: WillPopScope(
                onWillPop: () async => false,
                child: BlocConsumer<JoinLandingSessionBloc,
                    JoinLandingSessionState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is JoinLandingSessionLoading) {
                      return _loadingState(context);
                    } else if (state is JoinLandingSessionNone) {
                      return _noneState(context, state: state);
                    } else if (state is JoinLandingSessionVoting) {
                      return _votingState(context, state: state);
                    } else if (state is JoinLandingSessionVotingFinished) {
                      return _votingFinishedState(context, state: state);
                    } else if (state is JoinLandingSessionCoffeeVoting) {
                      return _coffeeVotingState(context);
                    } else if (state
                        is JoinLandingSessionCoffeeVotingFinished) {
                      return _coffeeVotingFinishedState(context);
                    } else if (state is JoinLandingSessionError) {
                      return _errorState(context, state: state);
                    } else if (state is JoinLandingLeftSession) {
                      return _endLeftSession(context, state: state);
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingState(BuildContext context) {
    return const PlanningLoadingState();
  }

  Widget _errorState(BuildContext context,
      {required JoinLandingSessionError state}) {
    return PlanningErrorState(
      sessionName: state.sessionName,
      errorCode: state.errorCode,
      errorDescription: state.errorDescription,
      onTapReconnect: _didTapReconnect,
    );
  }

  Widget _noneState(BuildContext context,
      {required JoinLandingSessionNone state}) {
    return PlanningHostNoneState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.edit,
          tooltip: 'Edit name',
          onPressed: null,
        ),
        PlanningCommandButton(
          icon: Icons.coffee,
          tooltip: 'Request coffee vote',
          onPressed: _didTapRequestCoffee,
        ),
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'Leave session',
          onPressed: null,
        ),
      ],
      participantCommands: const [],
    );
  }

  Widget _votingState(BuildContext context,
      {required JoinLandingSessionVoting state}) {
    return PlanningHostVotingState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.edit,
          tooltip: 'Edit name',
          onPressed: null,
        ),
        PlanningCommandButton(
          icon: Icons.coffee,
          tooltip: 'Request coffee vote',
          onPressed: _didTapRequestCoffee,
        ),
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'Leave session',
          onPressed: null,
        ),
      ],
      participantCommands: const [],
      ticketTitle: state.ticket.title,
      ticketDescription: state.ticket.description,
      ticketCommands: const [],
    );
  }

  Widget _votingFinishedState(BuildContext context,
      {required JoinLandingSessionVotingFinished state}) {
    return PlanningHostVotingFinishedState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.edit,
          tooltip: 'Edit name',
          onPressed: null,
        ),
        PlanningCommandButton(
          icon: Icons.coffee,
          tooltip: 'Request coffee vote',
          onPressed: _didTapRequestCoffee,
        ),
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'Leave session',
          onPressed: null,
        ),
      ],
      participantCommands: const [],
      ticketTitle: state.ticket.title,
      ticketDescription: state.ticket.description,
      ticketCommands: const [],
    );
  }

  Widget _coffeeVotingState(BuildContext context) {
    return const PlanningCoffeeVotingState();
  }

  Widget _coffeeVotingFinishedState(BuildContext context) {
    return const PlanningCoffeeVotingFinishedState();
  }

  Widget _endLeftSession(BuildContext context,
      {required JoinLandingLeftSession state}) {
    // TODO: Show left session state screen
    return PlanningEndSessionState(sessionName: state.sessionName);
  }
}
