import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamba/bloc/join/join_landing_session_bloc.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/screens/join/join_edit_name_screen.dart';
import 'package:mamba/screens/planning_session_sharing_screen.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/dialog/coming_soon_dialog.dart';
import 'package:mamba/widgets/dialog/confirmation_dialog.dart';
import 'package:mamba/widgets/dialog/modal_dialog.dart';
import 'package:mamba/widgets/states/join/planning_join_voting_state.dart';
import 'package:mamba/widgets/states/shared/planning_none_state.dart';
import 'package:mamba/widgets/states/shared/planning_voting_finished_state.dart';
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

  _didTapRequestCoffee() => ComingSoonDialog.show(context);

  _didTapShare() {
    ModalDialog.showModalBottomSheet(
      context: context,
      builder: (context) => PlanningSessionSharingScreen(
        sessionCode: widget.session.sessionCode,
        password: widget.session.password,
      ),
    );
  }

  _didTapReconnect() => widget.session.add(JoinSendReconnect());

  _didTapLeaveSession() {
    ConfirmationAlertDialog.show(
      context,
      title: 'Leave session',
      description: 'Are you sure you want to leave the session?',
      onConfirmation: () {
        widget.session.add(JoinSendLeaveSession());
      },
    );
  }

  _didTapEditName() {
    ModalDialog.showModalBottomSheet(
      context: context,
      builder: (context) => JoinEditNameScreen(
        name: widget.session.username,
        onChangeName: (newName) {
          widget.session.add(JoinSendChangeName(
            newUsername: newName,
          ));
          Navigator.pop(context);
        },
      ),
    );
  }

  _didSelectCard(PlanningCard selectedCard, String? tag) =>
      widget.session.add(JoinSendVote(
        selectedCard: selectedCard,
        tag: tag,
      ));

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
                      return _endLeftSessionState(context, state: state);
                    } else if (state is JoinLandingSessionEnded) {
                      return _sessionEndedState(context, state: state);
                    } else if (state is JoinLandingRemovedFromSession) {
                      return _removedFromSessionState(context, state: state);
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
    return PlanningNoneState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.edit,
          tooltip: 'Edit name',
          onPressed: _didTapEditName,
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
          onPressed: _didTapLeaveSession,
        ),
      ],
      participantCommands: const [],
    );
  }

  Widget _votingState(BuildContext context,
      {required JoinLandingSessionVoting state}) {
    return PlanningJoinVotingState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.edit,
          tooltip: 'Edit name',
          onPressed: _didTapEditName,
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
          onPressed: _didTapLeaveSession,
        ),
      ],
      ticketTitle: state.ticket.title,
      ticketDescription: state.ticket.description,
      selectedTags: state.ticket.selectedTags,
      availableCards: state.availableCards,
      selectedCard: state.selectedCard,
      onSelectCard: _didSelectCard,
    );
  }

  Widget _votingFinishedState(BuildContext context,
      {required JoinLandingSessionVotingFinished state}) {
    return PlanningVotingFinishedState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.edit,
          tooltip: 'Edit name',
          onPressed: _didTapEditName,
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
          onPressed: _didTapLeaveSession,
        ),
      ],
      participantCommands: const [],
      ticketTitle: state.ticket.title,
      ticketDescription: state.ticket.description,
      selectedTags: state.ticket.selectedTags,
      ticketCommands: const [],
      votes: state.votes,
    );
  }

  Widget _coffeeVotingState(BuildContext context) {
    return const PlanningCoffeeVotingState();
  }

  Widget _coffeeVotingFinishedState(BuildContext context) {
    return const PlanningCoffeeVotingFinishedState();
  }

  Widget _endLeftSessionState(BuildContext context,
      {required JoinLandingLeftSession state}) {
    return PlanningEndSessionState(
      sessionName: state.sessionName,
      description: 'You have left the session.',
    );
  }

  Widget _removedFromSessionState(BuildContext context,
      {required JoinLandingRemovedFromSession state}) {
    return PlanningEndSessionState(
      sessionName: state.sessionName,
      description: 'You have been removed from the session by the host.',
    );
  }

  Widget _sessionEndedState(BuildContext context,
      {required JoinLandingSessionEnded state}) {
    return PlanningEndSessionState(
      sessionName: state.sessionName,
      description: 'The session has been ended by the host.',
    );
  }
}
