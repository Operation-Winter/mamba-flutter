import 'package:bloc/bloc.dart';
import 'package:mamba/mixins/participants_list_mixin.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_participant_group_dto.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/repositories/local_storage_repository.dart';
import 'package:mamba/repositories/planning_host_session_repository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'host_landing_session_event.dart';
part 'host_landing_session_state.dart';

class HostLandingSessionBloc
    extends Bloc<HostLandingSessionEvent, HostLandingSessionState>
    with ParticipantsListMixin {
  final PlanningHostSessionRepository _hostSessionRepository =
      PlanningHostSessionRepository();
  final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();
  bool _sessionHasStarted = false;
  bool _sessionEnded = false;

  String sessionName;
  String? sessionCode;
  String? password;
  bool automaticallyCompleteVoting;
  List<PlanningCard> availableCards = [];
  Set<String> tags = {};
  PlanningTicket? ticket;

  Future<UuidValue> get _uuid async {
    var localUuid = await _localStorageRepository.getUuid();

    if (localUuid != null) {
      return localUuid;
    } else {
      var uuid = const Uuid().v4obj();
      await _localStorageRepository.uuid(uuid);
      return uuid;
    }
  }

  int? _timeLeft;

  HostLandingSessionBloc({
    required this.sessionName,
    this.password,
    required this.availableCards,
    required this.automaticallyCompleteVoting,
  }) : super(HostLandingSessionLoading()) {
    on<HostLandingSessionEvent>((event, emit) {
      // Send commands
      if (event is HostSendStartSession) {
        _sendStartCommand();
      } else if (event is HostSendAddTicket) {
        tags = event.tags;
        _sendAddTicketCommand(
          title: event.title,
          description: event.description,
          selectedTags: event.selectedTags,
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
        tags = event.tags;
        _sendEditTicketCommand(
          title: event.title,
          description: event.description,
          selectedTags: event.selectedTags,
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

    _hostSessionRepository.listen(
      _handleReceiveCommand,
      onError: (error) {
        if (!_sessionEnded) {
          add(HostLandingError(code: '1002', description: error.toString()));
        }
      },
      onDone: () {
        if (!_sessionEnded) {
          add(HostLandingError(
              code: '1001', description: 'Lost connection to server.'));
        }
      },
    );
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
      case PlanningHostReceiveCommandType.SESSION_IDLE_TIMEOUT:
        add(HostLandingError(
          code: '0007',
          description:
              'The session has been idle for too long and has been terminated.',
        ));
        break;
    }
  }

  _handleStateEvent({required PlanningSessionStateMessage message}) {
    sessionName = message.sessionName;
    availableCards = message.availableCards;
    ticket = message.ticket;
    sessionCode = message.sessionCode;

    _sessionHasStarted = true;
    _timeLeft = message.timeLeft;
  }

  _handleNoneStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var participantDtos =
        makeParticipantGroupDtos(participants: message.participants);

    emit(HostLandingSessionNone(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: message.coffeeRequestCount,
      spectatorCount: message.spectatorCount,
    ));
  }

  _handleVotingStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var ticket = message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: message.participants,
      votes: message.ticket?.ticketVotes,
    );

    emit(HostLandingSessionVoting(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: message.coffeeRequestCount,
      spectatorCount: message.spectatorCount,
      ticket: ticket,
    ));
  }

  _handleVotingFinishedStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var ticket = message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: message.participants,
      votes: message.ticket?.ticketVotes,
    );

    var voteGroups = makeGroupedCards(votes: message.ticket?.ticketVotes);

    emit(HostLandingSessionVotingFinished(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: message.coffeeRequestCount,
      spectatorCount: message.spectatorCount,
      ticket: ticket,
      voteGroups: voteGroups,
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

  _sendStartCommand() async {
    await _localStorageRepository.removeUuid();
    _hostSessionRepository.sendStartSessionCommand(
      uuid: await _uuid,
      sessionName: sessionName,
      automaticallyCompleteVoting: automaticallyCompleteVoting,
      availableCards: availableCards,
      password: password,
    );
  }

  _sendAddTicketCommand({
    required String title,
    String? description,
    required Set<String> selectedTags,
  }) async =>
      _hostSessionRepository.sendAddTicketCommand(
        uuid: await _uuid,
        title: title,
        description: description,
        selectedTags: selectedTags,
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

  _sendEditTicketCommand({
    required String title,
    String? description,
    required Set<String> selectedTags,
  }) async =>
      _hostSessionRepository.sendEditTicketCommand(
        uuid: await _uuid,
        title: title,
        description: description,
        selectedTags: selectedTags,
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
