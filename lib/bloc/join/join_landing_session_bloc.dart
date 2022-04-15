import 'package:bloc/bloc.dart';
import 'package:mamba/mixins/participants_list_mixin.dart';
import 'package:mamba/models/commands/join/planning_join_receive_command.dart';
import 'package:mamba/models/commands/join/planning_join_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_participant_dto.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/repositories/local_storage_repository.dart';
import 'package:mamba/repositories/planning_join_session_repository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'join_landing_session_event.dart';
part 'join_landing_session_state.dart';

class JoinLandingSessionBloc
    extends Bloc<JoinLandingSessionEvent, JoinLandingSessionState>
    with ParticipantsListMixin {
  final PlanningJoinSessionRepository _joinSessionRepository =
      PlanningJoinSessionRepository();
  final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();

  final String sessionCode;
  final String? password;
  String username;

  String _sessionName = '';
  List<PlanningCard> availableCards = [];
  Set<String> tags = {};
  PlanningTicket? ticket;
  List<PlanningParticipant> _planningParticipants = [];
  int? _timeLeft;
  bool _sessionJoined = false;
  bool _sessionEnded = false;

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

  JoinLandingSessionBloc({
    required this.sessionCode,
    this.password,
    required this.username,
  }) : super(JoinLandingSessionLoading()) {
    on<JoinLandingSessionEvent>((event, emit) {
      // Send commands
      if (event is JoinSendJoinSession) {
        _sendJoinCommand();
      } else if (event is JoinSendVote) {
        _sendVoteCommand();
      } else if (event is JoinSendLeaveSession) {
        _sendLeaveSessionCommand();
        emit(JoinLandingLeftSession(sessionName: _sessionName));
      } else if (event is JoinSendReconnect) {
        _sendReconnectCommand();
      } else if (event is JoinSendChangeName) {
        username = event.newUsername;
        _sendChangeNameCommand();
      }

      // Receive commands
      else if (event is JoinReceiveNoneState) {
        _handleNoneStateEvent(emit, message: event.message);
      } else if (event is JoinReceiveVotingState) {
        _handleVotingStateEvent(emit, message: event.message);
      } else if (event is JoinReceiveVotingFinishedState) {
        _handleVotingFinishedStateEvent(emit, message: event.message);
      } else if (event is JoinReceiveInvalidCommand) {
        _handleInvalidCommand(emit, message: event.message);
      } else if (event is JoinReceiveInvalidSession) {
        _handleInvalidSessionCommand(emit);
      } else if (event is JoinReceiveRemoveParticipant) {
        _handleRemoveParticipantCommand(emit);
      } else if (event is JoinReceiveEndSession) {
        _handleEndSessionCommand(emit);
      } else if (event is JoinLandingError) {
        emit(JoinLandingSessionError(
          sessionName: _sessionName,
          errorCode: event.code,
          errorDescription: event.description,
        ));
      }
    });
  }

  connect() async {
    await _joinSessionRepository.connect().catchError((error) {
      add(JoinLandingError(
          code: '1000', description: 'Failed to connect to server.'));
    });

    _joinSessionRepository.listen(
      _handleReceiveCommand,
      onError: (error) {
        if (!_sessionEnded) {
          add(JoinLandingError(code: '1002', description: error.toString()));
        }
      },
      onDone: () {
        if (!_sessionEnded) {
          add(JoinLandingError(
              code: '1001', description: 'Lost connection to server.'));
        }
      },
    );
  }

  _handleReceiveCommand(PlanningJoinReceiveCommand command) async {
    switch (command.type) {
      case PlanningJoinReceiveCommandType.NONE_STATE:
        add(JoinReceiveNoneState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningJoinReceiveCommandType.VOTING_STATE:
        add(JoinReceiveVotingState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningJoinReceiveCommandType.FINISHED_STATE:
        add(JoinReceiveVotingFinishedState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningJoinReceiveCommandType.INVALID_COMMAND:
        add(JoinReceiveInvalidCommand(
            message: command.message as PlanningInvalidCommandMessage));
        break;
      case PlanningJoinReceiveCommandType.INVALID_SESSION:
        add(JoinReceiveInvalidSession());
        break;
      case PlanningJoinReceiveCommandType.REMOVE_PARTICIPANT:
        _sessionEnded = true;
        add(JoinReceiveRemoveParticipant());
        break;
      case PlanningJoinReceiveCommandType.END_SESSION:
        _sessionEnded = true;
        add(JoinReceiveEndSession());
        break;
    }
  }

  _handleStateEvent({required PlanningSessionStateMessage message}) {
    _sessionName = message.sessionName;
    availableCards = message.availableCards;
    ticket = message.ticket;

    _sessionJoined = true;
    _planningParticipants = message.participants;
    _timeLeft = message.timeLeft;
  }

  _handleNoneStateEvent(Emitter<JoinLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var participantDtos =
        makeParticipantDtos(participants: message.participants);

    emit(JoinLandingSessionNone(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: 0,
      spectatorCount: 0,
    ));
  }

  _handleVotingStateEvent(Emitter<JoinLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var ticket = message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantDtos(
      participants: message.participants,
      votes: message.ticket?.ticketVotes,
    );

    emit(JoinLandingSessionVoting(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: 0,
      spectatorCount: 0,
      ticket: ticket,
    ));
  }

  _handleVotingFinishedStateEvent(Emitter<JoinLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var ticket = message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantDtos(
      participants: message.participants,
      votes: message.ticket?.ticketVotes,
    );

    emit(JoinLandingSessionVotingFinished(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: 0,
      spectatorCount: 0,
      ticket: ticket,
    ));
  }

  _handleInvalidCommand(Emitter<JoinLandingSessionState> emit,
      {required PlanningInvalidCommandMessage message}) {
    emit(JoinLandingSessionError(
      sessionName: _sessionName,
      errorCode: message.code,
      errorDescription: message.description,
    ));
  }

  _handleInvalidSessionCommand(Emitter<JoinLandingSessionState> emit) {
    emit(JoinLandingSessionError(
      sessionName: _sessionName,
      errorCode: '0001',
      errorDescription:
          'The specified session code doesn\'t exist or is no longer available.',
    ));
  }

  _handleRemoveParticipantCommand(Emitter<JoinLandingSessionState> emit) {
    emit(JoinLandingRemovedFromSession(sessionName: _sessionName));
  }

  _handleEndSessionCommand(Emitter<JoinLandingSessionState> emit) =>
      emit(JoinLandingSessionEnded(sessionName: _sessionName));

  _sendJoinCommand() async {
    await _localStorageRepository.removeUuid();
    _joinSessionRepository.sendJoinSessionCommand(
      uuid: await _uuid,
      participantName: username,
      sessionCode: sessionCode,
    );
  }

  _sendChangeNameCommand() async => _joinSessionRepository
      .sendChangeNameCommand(uuid: await _uuid, name: username);

  _sendVoteCommand() {
    print('Join: Send vote command');
  }

  _sendLeaveSessionCommand() async {
    _sessionEnded = true;
    _joinSessionRepository.sendLeaveSessionCommand(uuid: await _uuid);
  }

  _sendReconnectCommand() async {
    await connect();
    if (!_sessionJoined) {
      _sendJoinCommand();
    } else {
      _joinSessionRepository.sendReconnectCommand(uuid: await _uuid);
    }
  }
}
