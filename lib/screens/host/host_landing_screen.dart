import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamba/bloc/host/host_landing_session_bloc.dart';
import 'package:mamba/screens/host/host_ticket_details_screen.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/cards/planning_session_participants_card.dart';
import 'package:mamba/widgets/dialog/confirmation_dialog.dart';
import 'package:mamba/widgets/states/shared/planning_none_state.dart';
import 'package:mamba/widgets/states/shared/planning_voting_finished_state.dart';
import 'package:mamba/widgets/states/host/planning_host_voting_state.dart';
import 'package:mamba/widgets/states/shared/planning_coffee_voting_finished_state.dart';
import 'package:mamba/widgets/states/shared/planning_coffee_voting_state.dart';
import 'package:mamba/widgets/states/shared/planning_end_session_state.dart';
import 'package:mamba/widgets/states/shared/planning_loading_state.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/widgets/states/shared/planning_error_state.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

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
  late final HostLandingSessionBloc session;

  HostLandingScreen({
    Key? key,
    required String sessionName,
    String? password,
    List<PlanningCard> availableCards = const [],
    bool automaticallyCompleteVoting = false,
    Set<String> tags = const {},
  }) : super(key: key) {
    session = HostLandingSessionBloc(
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
  void initState() {
    super.initState();
    _connect();
  }

  Future<void> _connect() async {
    await widget.session.connect();
    widget.session.add(HostSendStartSession());
  }

  _didTapAddTicket() {
    showBarModalBottomSheet(
      expand: true,
      context: context,
      builder: (context) => HostTicketDetailsScreen(
        tags: widget.session.tags,
        onAddTicket: (title, description, tags) {
          widget.session.add(HostSendAddTicket(
            title: title,
            description: description,
          ));
          Navigator.pop(context);
        },
      ),
    );
  }

  _didTapEditTicket() {
    showBarModalBottomSheet(
      expand: true,
      context: context,
      builder: (context) => HostTicketDetailsScreen(
        title: widget.session.ticket?.title,
        description: widget.session.ticket?.description,
        tags: widget.session.tags,
        onAddTicket: (title, description, tags) {
          widget.session.add(HostSendEditTicket(
            title: title,
            description: description,
          ));
          Navigator.pop(context);
        },
      ),
    );
  }

  _didTapRequestCoffee() => print('Did tap request coffee');

  _didTapShare() => print('Did tap share');

  _didTapAddTimer() => print('Did tap add timer');

  _didTapFinishVoting() => widget.session.add(HostSendFinishVoting());

  _didTapEndSession() {
    ConfirmationAlertDialog.show(
      context,
      title: 'End session',
      description: 'Are you sure you want to end the session?',
      onConfirmation: () {
        widget.session.add(HostSendEndSession());
      },
    );
  }

  _didTapRemoveParticipant(UuidValue participantId) => widget.session
      .add(HostSendRemoveParticipant(participantId: participantId));

  _didTapSkipVote(UuidValue participantId) =>
      widget.session.add(HostSendSkipVote(participantId: participantId));

  _didTapRevote() => widget.session.add(HostSendRevote());

  _didTapExport() => widget.session.add(HostSendPreviousTickets());

  _didTapReconnect() => widget.session.add(HostSendReconnect());

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
                child: BlocConsumer<HostLandingSessionBloc,
                    HostLandingSessionState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is HostLandingSessionLoading) {
                      return _loadingState(context);
                    } else if (state is HostLandingSessionNone) {
                      return _noneState(context, state: state);
                    } else if (state is HostLandingSessionVoting) {
                      return _votingState(context, state: state);
                    } else if (state is HostLandingSessionVotingFinished) {
                      return _votingFinishedState(context, state: state);
                    } else if (state is HostLandingSessionCoffeeVoting) {
                      return _coffeeVotingState(context);
                    } else if (state
                        is HostLandingSessionCoffeeVotingFinished) {
                      return _coffeeVotingFinishedState(context);
                    } else if (state is HostLandingSessionError) {
                      return _errorState(context, state: state);
                    } else if (state is HostLandingSessionEnded) {
                      return _endSessionState(context, state: state);
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
      {required HostLandingSessionError state}) {
    return PlanningErrorState(
      sessionName: state.sessionName,
      errorCode: state.errorCode,
      errorDescription: state.errorDescription,
      onTapReconnect: _didTapReconnect,
    );
  }

  Widget _noneState(BuildContext context,
      {required HostLandingSessionNone state}) {
    return PlanningNoneState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.coffee,
          tooltip: 'Request coffee vote',
          onPressed: _didTapRequestCoffee,
        ),
        PlanningCommandButton(
          icon: Icons.add,
          tooltip: 'Add ticket',
          onPressed: _didTapAddTicket,
        ),
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'End session',
          onPressed: _didTapEndSession,
        ),
      ],
      participantCommands: [
        PlanningParticipantCommand(
          title: 'Remove participant',
          onTap: _didTapRemoveParticipant,
        ),
      ],
    );
  }

  Widget _votingState(BuildContext context,
      {required HostLandingSessionVoting state}) {
    return PlanningHostVotingState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.coffee,
          tooltip: 'Request coffee vote',
          onPressed: _didTapRequestCoffee,
        ),
        PlanningCommandButton(
          icon: Icons.add,
          tooltip: 'Add ticket',
          onPressed: _didTapAddTicket,
        ),
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'End session',
          onPressed: _didTapEndSession,
        ),
      ],
      participantCommands: [
        PlanningParticipantCommand(
          title: 'Skip vote',
          onTap: _didTapSkipVote,
        ),
        PlanningParticipantCommand(
          title: 'Remove participant',
          onTap: _didTapRemoveParticipant,
        ),
      ],
      ticketTitle: state.ticket.title,
      ticketDescription: state.ticket.description,
      ticketCommands: [
        PlanningCommandButton(
          icon: Icons.timer,
          tooltip: 'Add timer',
          onPressed: _didTapAddTimer,
        ),
        PlanningCommandButton(
          icon: Icons.how_to_vote,
          tooltip: 'Finish voting',
          onPressed: _didTapFinishVoting,
        ),
        PlanningCommandButton(
          icon: Icons.edit,
          tooltip: 'Edit ticket',
          onPressed: _didTapEditTicket,
        ),
      ],
    );
  }

  Widget _votingFinishedState(BuildContext context,
      {required HostLandingSessionVotingFinished state}) {
    return PlanningVotingFinishedState(
      sessionName: state.sessionName,
      participants: state.participants,
      coffeeVoteCount: state.coffeeVoteCount,
      spectatorCount: state.spectatorCount,
      commands: [
        PlanningCommandButton(
          icon: Icons.coffee,
          tooltip: 'Request coffee vote',
          onPressed: _didTapRequestCoffee,
        ),
        PlanningCommandButton(
          icon: Icons.add,
          tooltip: 'Add ticket',
          onPressed: _didTapAddTicket,
        ),
        PlanningCommandButton(
          icon: Icons.share,
          tooltip: 'Share session',
          onPressed: _didTapShare,
        ),
        PlanningCommandButton(
          icon: Icons.close,
          tooltip: 'End session',
          onPressed: _didTapEndSession,
        ),
      ],
      participantCommands: [
        PlanningParticipantCommand(
          title: 'Remove participant',
          onTap: _didTapRemoveParticipant,
        ),
      ],
      ticketTitle: state.ticket.title,
      ticketDescription: state.ticket.description,
      ticketCommands: [
        PlanningCommandButton(
          icon: Icons.download,
          tooltip: 'Export results',
          onPressed: _didTapExport,
        ),
        PlanningCommandButton(
          icon: Icons.replay,
          tooltip: 'Revote',
          onPressed: _didTapRevote,
        ),
      ],
      votes: state.votes,
    );
  }

  Widget _coffeeVotingState(BuildContext context) {
    return const PlanningCoffeeVotingState();
  }

  Widget _coffeeVotingFinishedState(BuildContext context) {
    return const PlanningCoffeeVotingFinishedState();
  }

  Widget _endSessionState(BuildContext context,
      {required HostLandingSessionEnded state}) {
    return PlanningEndSessionState(
      sessionName: state.sessionName,
      description: 'You have ended the session.',
    );
  }
}
