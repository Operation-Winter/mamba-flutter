import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command_type.dart';
import 'package:mamba/models/commands/host/planning_host_send_command.dart';
import 'package:mamba/models/commands/host/planning_host_send_command_type.dart';
import 'package:mamba/models/messages/planning_start_session_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/repositories/planning_host_session_repository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'host_landing_session_event.dart';
part 'host_landing_session_state.dart';

class HostLandingSessionBloc
    extends Bloc<HostLandingSessionEvent, HostLandingSessionState> {
  final PlanningHostSessionRepository _hostSessionRepository =
      PlanningHostSessionRepository();
  UuidValue uuid = const Uuid().v4obj();
  String? sessionCode;
  String sessionName;
  String? participantName;
  List<PlanningCard> availableCards = [];
  List<PlanningParticipant> planningParticipants = [];
  PlanningCard? selectedCard;
  PlanningTicket? ticket;
  bool automaticallyCompleteVoting;
  String? password;
  Set<String> tags;

  HostLandingSessionBloc({
    required this.sessionName,
    this.password,
    required this.availableCards,
    required this.automaticallyCompleteVoting,
    required this.tags,
  }) : super(HostLandingSessionLoading()) {
    _hostSessionRepository.listen(_handleReceiveCommand,
        onError: (error) {}, onDone: () {});

    on<HostLandingSessionEvent>((event, emit) {
      // Send commands
      if (event is HostSendStartSession) {
        _sendStartCommand();
      } else if (event is HostSendAddTicket) {
      } else if (event is HostSendSkipVote) {
      } else if (event is HostSendRemoveParticipant) {
      } else if (event is HostSendEndSession) {
      } else if (event is HostSendFinishVoting) {
      } else if (event is HostSendRevote) {
      } else if (event is HostSendReconnect) {
      } else if (event is HostSendEditTicket) {
      } else if (event is HostSendAddTimer) {
      } else if (event is HostSendCancelTimer) {
      } else if (event is HostSendPreviousTickets) {
      }

      // Receive commands
      else if (event is HostReceiveNoneState) {
        emit(HostLandingSessionNone());
      } else if (event is HostReceiveVotingState) {
      } else if (event is HostReceiveVotingFinishedState) {
      } else if (event is HostReceiveInvalidCommand) {
      } else if (event is HostReceivePreviousTickets) {}
    });
    add(HostSendStartSession());
  }

  _handleReceiveCommand(PlanningHostReceiveCommand command) async {
    switch (command.type) {
      case PlanningHostReceiveCommandType.NONE_STATE:
        add(HostReceiveNoneState());
        break;
      case PlanningHostReceiveCommandType.VOTING_STATE:
        add(HostReceiveVotingState());
        break;
      case PlanningHostReceiveCommandType.FINISHED_STATE:
        add(HostReceiveVotingFinishedState());
        break;
      case PlanningHostReceiveCommandType.INVALID_COMMAND:
        add(HostReceiveInvalidCommand());
        break;
      case PlanningHostReceiveCommandType.PREVIOUS_TICKETS:
        // TODO: Implement previous tickets handling
        break;
    }
  }

  _sendStartCommand() => _hostSessionRepository.sendStartSessionCommand(
        uuid: uuid,
        sessionName: sessionName,
        automaticallyCompleteVoting: automaticallyCompleteVoting,
        availableCards: availableCards,
      );
}
