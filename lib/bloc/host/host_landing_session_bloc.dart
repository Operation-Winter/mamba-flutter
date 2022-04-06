import 'package:bloc/bloc.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command_type.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_card.dart';
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

  String sessionName;
  String? password;
  bool automaticallyCompleteVoting;
  List<PlanningCard> availableCards = [];
  Set<String> tags;

  UuidValue _uuid = const Uuid().v4obj();
  String? _sessionCode;
  String? _participantName;
  List<PlanningParticipant> _planningParticipants = [];
  PlanningCard? _selectedCard;
  PlanningTicket? _ticket;
  int? _timeLeft;

  HostLandingSessionBloc({
    required this.sessionName,
    this.password,
    required this.availableCards,
    required this.automaticallyCompleteVoting,
    required this.tags,
  }) : super(HostLandingSessionLoading()) {
    _hostSessionRepository.listen(_handleReceiveCommand, onError: (error) {
      print('Socket error $error');
    }, onDone: () {
      print('Socket closed');
    });

    on<HostLandingSessionEvent>((event, emit) {
      // Send commands
      if (event is HostSendStartSession) {
        _sendStartCommand();
      } else if (event is HostSendAddTicket) {
        _sendAddTicketCommand(
          title: event.title,
          description: event.description,
        );
      } else if (event is HostSendSkipVote) {
        _sendSkipVoteCommand(participantId: event.participantId);
      } else if (event is HostSendRemoveParticipant) {
        _sendRemoveParticipantCommand(participantId: event.participantId);
      } else if (event is HostSendEndSession) {
        _sendEndSessionCommand();
      } else if (event is HostSendFinishVoting) {
        _sendFinishVotingCommand();
      } else if (event is HostSendRevote) {
        _sendRevoteCommand();
      } else if (event is HostSendReconnect) {
        _sendReconnectCommand();
      } else if (event is HostSendEditTicket) {
        _sendEditTicketCommand(
          title: event.title,
          description: event.description,
        );
      } else if (event is HostSendAddTimer) {
        _sendAddTimerCommand(timeInterval: event.timeInterval);
      } else if (event is HostSendCancelTimer) {
        _sendCancelTimerCommand();
      } else if (event is HostSendPreviousTickets) {
        _sendPreviousTicketsCommand();
      }

      // Receive commands
      else if (event is HostReceiveNoneState) {
        _handleNoneStateEvent(emit, message: event.message);
      } else if (event is HostReceiveVotingState) {
        _handleVotingStateEvent(emit, message: event.message);
      } else if (event is HostReceiveVotingFinishedState) {
        _handleVotingFinishedStateEvent(emit, message: event.message);
      } else if (event is HostReceiveInvalidCommand) {
        emit(HostLandingSessionError());
      } else if (event is HostReceivePreviousTickets) {
        emit(HostLandingSessionPreviousTickets());
      }
    });
  }

  _handleReceiveCommand(PlanningHostReceiveCommand command) async {
    switch (command.type) {
      case PlanningHostReceiveCommandType.NONE_STATE:
        add(HostReceiveNoneState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningHostReceiveCommandType.VOTING_STATE:
        add(HostReceiveVotingState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningHostReceiveCommandType.FINISHED_STATE:
        add(HostReceiveVotingFinishedState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningHostReceiveCommandType.INVALID_COMMAND:
        add(HostReceiveInvalidCommand());
        break;
      case PlanningHostReceiveCommandType.PREVIOUS_TICKETS:
        add(HostReceivePreviousTickets());
        break;
    }
  }

  _handleStateEvent({required PlanningSessionStateMessage message}) {
    sessionName = message.sessionName;
    availableCards = message.availableCards;
    _sessionCode = message.sessionCode;
    _planningParticipants = message.participants;
    _ticket = message.ticket;
    _timeLeft = message.timeLeft;
  }

  _handleNoneStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    // TODO: Map required data for none state widgets
    emit(HostLandingSessionNone(
      sessionName: sessionName,
      participants: message.participants,
      coffeeVoteCount: 0,
      spectatorCount: 0,
    ));
  }

  _handleVotingStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    // TODO: Map required data for voting state widgets
    emit(HostLandingSessionVoting());
  }

  _handleVotingFinishedStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    // TODO: Map required data for voting finished state widgets
    emit(HostLandingSessionVotingFinished());
  }

  _sendStartCommand() => _hostSessionRepository.sendStartSessionCommand(
        uuid: _uuid,
        sessionName: sessionName,
        automaticallyCompleteVoting: automaticallyCompleteVoting,
        availableCards: availableCards,
      );

  _sendAddTicketCommand({required String title, String? description}) =>
      _hostSessionRepository.sendAddTicketCommand(
        uuid: _uuid,
        title: title,
        description: description,
      );

  _sendSkipVoteCommand({required UuidValue participantId}) =>
      _hostSessionRepository.sendSkipVoteCommand(
        uuid: _uuid,
        participantId: participantId,
      );

  _sendRemoveParticipantCommand({required UuidValue participantId}) =>
      _hostSessionRepository.sendRemoveParticipantCommand(
        uuid: _uuid,
        participantId: participantId,
      );

  _sendEndSessionCommand() =>
      _hostSessionRepository.sendEndSessionCommand(uuid: _uuid);

  _sendFinishVotingCommand() =>
      _hostSessionRepository.sendFinishVotingCommand(uuid: _uuid);

  _sendRevoteCommand() => _hostSessionRepository.sendRevoteCommand(uuid: _uuid);

  _sendReconnectCommand() =>
      _hostSessionRepository.sendReconnectCommand(uuid: _uuid);

  _sendEditTicketCommand({required String title, String? description}) =>
      _hostSessionRepository.sendEditTicketCommand(
        uuid: _uuid,
        title: title,
        description: description,
      );

  _sendAddTimerCommand({required int timeInterval}) =>
      _hostSessionRepository.sendAddTimerCommand(
        uuid: _uuid,
        timeInterval: timeInterval,
      );

  _sendCancelTimerCommand() =>
      _hostSessionRepository.sendCancelTimerCommand(uuid: _uuid);

  _sendPreviousTicketsCommand() =>
      _hostSessionRepository.sendPreviousTicketsCommand(uuid: _uuid);
}
