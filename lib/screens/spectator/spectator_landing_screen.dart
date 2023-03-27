import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamba/bloc/spectator/spectator_landing_session_bloc.dart';
import 'package:mamba/screens/shared/planning_session_sharing_screen.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/dialog/confirmation_dialog.dart';
import 'package:mamba/widgets/dialog/modal_dialog.dart';
import 'package:mamba/widgets/states/shared/planning_coffee_voting_finished_state.dart';
import 'package:mamba/widgets/states/shared/planning_end_session_state.dart';
import 'package:mamba/widgets/states/shared/planning_error_state.dart';
import 'package:mamba/widgets/states/shared/planning_loading_state.dart';
import 'package:mamba/widgets/states/shared/planning_none_state.dart';
import 'package:mamba/widgets/states/shared/planning_voting_finished_state.dart';
import 'package:mamba/widgets/states/shared/planning_voting_state.dart';

class SpectatorLandingScreen extends StatefulWidget {
  static String route = '/spectator/landing';
  late final SpectatorLandingSessionBloc session;
  final bool reconnect;

  SpectatorLandingScreen({
    Key? key,
    String? sessionCode,
    String? password,
    required this.reconnect,
  }) : super(key: key) {
    session = SpectatorLandingSessionBloc(
      sessionCode: sessionCode,
      password: password,
      reconnect: reconnect,
    );
  }

  @override
  State<SpectatorLandingScreen> createState() => _SpectatorLandingScreenState();
}

class _SpectatorLandingScreenState extends State<SpectatorLandingScreen> {
  @override
  void initState() {
    super.initState();
    _connect();
  }

  Future<void> _connect() async {
    if (!widget.reconnect) {
      await widget.session.connect();
      widget.session.add(SpectatorSendJoinSession());
    } else {
      widget.session.add(SpectatorSendReconnect());
    }
  }

  _didTapShare() {
    ModalDialog.showModalBottomSheet(
      context: context,
      builder: (context) => PlanningSessionSharingScreen(
        sessionCode: widget.session.sessionCode ?? 'Invalid session code',
        password: widget.session.password,
      ),
    );
  }

  _didTapReconnect() => widget.session.add(SpectatorSendReconnect());

  _didTapLeaveSession() {
    ConfirmationAlertDialog.show(
      context,
      title: 'Leave session',
      description: 'Are you sure you want to leave the session?',
      onConfirmation: () {
        widget.session.add(SpectatorSendLeaveSession());
      },
    );
  }

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
                child: BlocConsumer<SpectatorLandingSessionBloc,
                    SpectatorLandingSessionState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is SpectatorLandingSessionLoading) {
                      return _loadingState(context);
                    } else if (state is SpectatorLandingSessionNone) {
                      return _noneState(context, state: state);
                    } else if (state is SpectatorLandingSessionVoting) {
                      return _votingState(context, state: state);
                    } else if (state is SpectatorLandingSessionVotingFinished) {
                      return _votingFinishedState(context, state: state);
                    } else if (state is SpectatorLandingSessionCoffeeVoting) {
                      return _coffeeVotingState(context, state: state);
                    } else if (state
                        is SpectatorLandingSessionCoffeeVotingFinished) {
                      return _coffeeVotingFinishedState(context, state: state);
                    } else if (state is SpectatorLandingSessionError) {
                      return _errorState(context, state: state);
                    } else if (state is SpectatorLandingLeftSession) {
                      return _endLeftSessionState(context, state: state);
                    } else if (state is SpectatorLandingSessionEnded) {
                      return _sessionEndedState(context, state: state);
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
      {required SpectatorLandingSessionError state}) {
    return PlanningErrorState(
      sessionName: state.sessionName,
      errorCode: state.errorCode,
      errorDescription: state.errorDescription,
      onTapReconnect: _didTapReconnect,
    );
  }

  Widget _noneState(BuildContext context,
      {required SpectatorLandingSessionNone state}) {
    return PlanningNoneState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'Leave session',
          onPressed: _didTapLeaveSession,
        ),
      ],
      participantCommands: const [],
    );
  }

  Widget _votingState(BuildContext context,
      {required SpectatorLandingSessionVoting state}) {
    return PlanningVotingState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'Leave session',
          onPressed: _didTapLeaveSession,
        ),
      ],
      ticketTitle: state.ticket.title,
      ticketDescription: state.ticket.description,
      ticketCommands: const [],
      participantCommands: const [],
      timeLeft: state.timeLeft,
    );
  }

  Widget _votingFinishedState(BuildContext context,
      {required SpectatorLandingSessionVotingFinished state}) {
    return PlanningVotingFinishedState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'Leave session',
          onPressed: _didTapLeaveSession,
        ),
      ],
      participantCommands: const [],
      ticketTitle: state.ticket.title,
      ticketDescription: state.ticket.description,
      ticketCommands: const [],
      voteGroups: state.voteGroups,
    );
  }

  Widget _coffeeVotingState(BuildContext context,
      {required SpectatorLandingSessionCoffeeVoting state}) {
    return PlanningCoffeeVotingFinishedState(
      sessionName: state.sessionName,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'Leave session',
          onPressed: _didTapLeaveSession,
        ),
      ],
      votingResultsCommands: const [],
      coffeeVotes: state.coffeeVotes,
    );
  }

  Widget _coffeeVotingFinishedState(BuildContext context,
      {required SpectatorLandingSessionCoffeeVotingFinished state}) {
    return PlanningCoffeeVotingFinishedState(
      sessionName: state.sessionName,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'Leave session',
          onPressed: _didTapLeaveSession,
        ),
      ],
      votingResultsCommands: const [],
      coffeeVotes: state.coffeeVotes,
    );
  }

  Widget _endLeftSessionState(BuildContext context,
      {required SpectatorLandingLeftSession state}) {
    return PlanningEndSessionState(
      sessionName: state.sessionName,
      description: 'You have left the session.',
    );
  }

  Widget _sessionEndedState(BuildContext context,
      {required SpectatorLandingSessionEnded state}) {
    return PlanningEndSessionState(
      sessionName: state.sessionName,
      description: 'The session has been ended by the host.',
    );
  }
}
