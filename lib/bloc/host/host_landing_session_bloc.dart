import 'package:bloc/bloc.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_participant_dto.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/models/planning_ticket_vote.dart';
import 'package:mamba/repositories/local_storage_repository.dart';
import 'package:mamba/repositories/planning_host_session_repository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

part 'host_landing_session_event.dart';
part 'host_landing_session_state.dart';

class HostLandingSessionBloc
    extends Bloc<HostLandingSessionEvent, HostLandingSessionState> {
  final PlanningHostSessionRepository _hostSessionRepository =
      PlanningHostSessionRepository();
  final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();
  bool _sessionHasStarted = false;
  bool _sessionEnded = false;

  String sessionName;
  String? password;
  bool automaticallyCompleteVoting;
  List<PlanningCard> availableCards = [];
  Set<String> tags;

  Future<UuidValue> get _uuid async {
    var localUuid = await _localStorageRepository.getUuid();

    if (localUuid != null) {
      return localUuid;
    } else {
      var uuid = const Uuid().v4obj();
      _localStorageRepository.uuid = uuid;
      return uuid;
    }
  }

  String? _sessionCode;
  List<PlanningParticipant> _planningParticipants = [];
  PlanningTicket? _ticket;
  int? _timeLeft;

  HostLandingSessionBloc({
    required this.sessionName,
    this.password,
    required this.availableCards,
    required this.automaticallyCompleteVoting,
    required this.tags,
  }) : super(HostLandingSessionLoading()) {
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
        _sessionEnded = true;
        emit(HostLandingSessionEnded(sessionName: sessionName));
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
        _handleInvalidCommand(emit, message: event.message);
      } else if (event is HostReceivePreviousTickets) {
        emit(HostLandingSessionPreviousTickets());
      } else if (event is HostLandingError) {
        emit(HostLandingSessionError(
          sessionName: sessionName,
          errorCode: event.code,
          errorDescription: event.description,
        ));
      }
    });
  }

  connect() async {
    await _hostSessionRepository.connect().catchError((error) {
      add(HostLandingError(
          code: '1000', description: 'Failed to connect to server.'));
    });

    _hostSessionRepository.listen(_handleReceiveCommand, onError: (error) {
      if (!_sessionEnded) {
        add(HostLandingError(code: '1002', description: error.toString()));
      }
    }, onDone: () {
      if (!_sessionEnded) {
        add(HostLandingError(
            code: '1001', description: 'Lost connection to server.'));
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
        add(HostReceiveInvalidCommand(
            message: command.message as PlanningInvalidCommandMessage));
        break;
      case PlanningHostReceiveCommandType.PREVIOUS_TICKETS:
        add(HostReceivePreviousTickets());
        break;
    }
  }

  List<PlanningParticipantDto> _makeParticipantDtos({
    required List<PlanningParticipant> participants,
    List<PlanningTicketVote>? votes,
  }) {
    return participants.map((participant) {
      var participantVotes = votes
          ?.where(
              (element) => element.participantId == participant.participantId)
          .map((vote) => vote.planningCard?.title)
          .whereNotNull()
          .toList();

      return PlanningParticipantDto(
        participantId: participant.participantId,
        name: participant.name,
        connected: participant.connected,
        votes: participantVotes,
      );
    }).toList();
  }

  _handleStateEvent({required PlanningSessionStateMessage message}) {
    _sessionHasStarted = true;
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
    var participantDtos =
        _makeParticipantDtos(participants: message.participants);

    emit(HostLandingSessionNone(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: 0,
      spectatorCount: 0,
    ));
  }

  _handleVotingStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var ticket = message.ticket;
    if (ticket == null) return;

    var participantDtos = _makeParticipantDtos(
      participants: message.participants,
      votes: message.ticket?.ticketVotes,
    );

    emit(HostLandingSessionVoting(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: 0,
      spectatorCount: 0,
      ticket: ticket,
    ));
  }

  _handleVotingFinishedStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var ticket = message.ticket;
    if (ticket == null) return;

    var participantDtos = _makeParticipantDtos(
      participants: message.participants,
      votes: message.ticket?.ticketVotes,
    );

    emit(HostLandingSessionVotingFinished(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: 0,
      spectatorCount: 0,
      ticket: ticket,
    ));
  }

  _handleInvalidCommand(Emitter<HostLandingSessionState> emit,
      {required PlanningInvalidCommandMessage message}) {
    emit(HostLandingSessionError(
      sessionName: sessionName,
      errorCode: message.code,
      errorDescription: message.description,
    ));
  }

  _sendStartCommand() async => _hostSessionRepository.sendStartSessionCommand(
        uuid: await _uuid,
        sessionName: sessionName,
        automaticallyCompleteVoting: automaticallyCompleteVoting,
        availableCards: availableCards,
      );

  _sendAddTicketCommand({required String title, String? description}) async =>
      _hostSessionRepository.sendAddTicketCommand(
        uuid: await _uuid,
        title: title,
        description: description,
      );

  _sendSkipVoteCommand({required UuidValue participantId}) async =>
      _hostSessionRepository.sendSkipVoteCommand(
        uuid: await _uuid,
        participantId: participantId,
      );

  _sendRemoveParticipantCommand({required UuidValue participantId}) async =>
      _hostSessionRepository.sendRemoveParticipantCommand(
        uuid: await _uuid,
        participantId: participantId,
      );

  _sendEndSessionCommand() async {
    _hostSessionRepository.sendEndSessionCommand(uuid: await _uuid);
    _localStorageRepository.removeUuid();
  }

  _sendFinishVotingCommand() async =>
      _hostSessionRepository.sendFinishVotingCommand(uuid: await _uuid);

  _sendRevoteCommand() async =>
      _hostSessionRepository.sendRevoteCommand(uuid: await _uuid);

  _sendReconnectCommand() async {
    await connect();
    if (!_sessionHasStarted) {
      _sendStartCommand();
    } else {
      _hostSessionRepository.sendReconnectCommand(uuid: await _uuid);
    }
  }

  _sendEditTicketCommand({required String title, String? description}) async =>
      _hostSessionRepository.sendEditTicketCommand(
        uuid: await _uuid,
        title: title,
        description: description,
      );

  _sendAddTimerCommand({required int timeInterval}) async =>
      _hostSessionRepository.sendAddTimerCommand(
        uuid: await _uuid,
        timeInterval: timeInterval,
      );

  _sendCancelTimerCommand() async =>
      _hostSessionRepository.sendCancelTimerCommand(uuid: await _uuid);

  _sendPreviousTicketsCommand() async =>
      _hostSessionRepository.sendPreviousTicketsCommand(uuid: await _uuid);
}
