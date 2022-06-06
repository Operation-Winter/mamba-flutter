import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamba/mixins/participants_list_mixin.dart';
import 'package:mamba/models/commands/spectator/planning_spectator_receive_command.dart';
import 'package:mamba/models/commands/spectator/planning_spectator_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_participant_group_dto.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/repositories/local_storage_repository.dart';
import 'package:mamba/repositories/planning_spectator_session_repository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'spectator_landing_session_event.dart';
part 'spectator_landing_session_state.dart';

class SpectatorLandingSessionBloc
    extends Bloc<SpectatorLandingSessionEvent, SpectatorLandingSessionState>
    with ParticipantsListMixin {
  final PlanningSpectatorSessionRepository _spectatorSessionRepository =
      PlanningSpectatorSessionRepository();
  final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();

  final String sessionCode;
  String? password;

  String _sessionName = '';
  List<PlanningCard> availableCards = [];
  Set<String> tags = {};
  PlanningTicket? ticket;
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

  SpectatorLandingSessionBloc({
    required this.sessionCode,
    this.password,
  }) : super(SpectatorLandingSessionLoading()) {
    on<SpectatorLandingSessionEvent>((event, emit) async {
      if (event is SpectatorSendJoinSession) {
        _sendJoinCommand();
      } else if (event is SpectatorSendLeaveSession) {
        _sendLeaveSessionCommand();
        emit(SpectatorLandingLeftSession(sessionName: _sessionName));
      } else if (event is SpectatorSendReconnect) {
        _sendReconnectCommand();
      }

      // Receive commands
      else if (event is SpectatorReceiveNoneState) {
        _handleNoneStateEvent(emit, message: event.message);
      } else if (event is SpectatorReceiveVotingState) {
        _handleVotingStateEvent(emit, message: event.message);
      } else if (event is SpectatorReceiveVotingFinishedState) {
        _handleVotingFinishedStateEvent(emit, message: event.message);
      } else if (event is SpectatorReceiveInvalidCommand) {
        _handleInvalidCommand(emit, message: event.message);
      } else if (event is SpectatorReceiveInvalidSession) {
        _handleInvalidSessionCommand(emit);
      } else if (event is SpectatorReceiveEndSession) {
        _handleEndSessionCommand(emit);
      } else if (event is SpectatorLandingError) {
        emit(SpectatorLandingSessionError(
          sessionName: _sessionName,
          errorCode: event.code,
          errorDescription: event.description,
        ));
      }
    });
  }

  connect() async {
    await _spectatorSessionRepository.connect().catchError((error) {
      add(SpectatorLandingError(
          code: '1000', description: 'Failed to connect to server.'));
    });

    _spectatorSessionRepository.listen(
      _handleReceiveCommand,
      onError: (error) {
        if (!_sessionEnded) {
          add(SpectatorLandingError(
              code: '1002', description: error.toString()));
        }
      },
      onDone: () {
        if (!_sessionEnded) {
          add(SpectatorLandingError(
              code: '1001', description: 'Lost connection to server.'));
        }
      },
    );
  }

  _handleReceiveCommand(PlanningSpectatorReceiveCommand command) async {
    switch (command.type) {
      case PlanningSpectatorReceiveCommandType.NONE_STATE:
        add(SpectatorReceiveNoneState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningSpectatorReceiveCommandType.VOTING_STATE:
        add(SpectatorReceiveVotingState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningSpectatorReceiveCommandType.FINISHED_STATE:
        add(SpectatorReceiveVotingFinishedState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningSpectatorReceiveCommandType.INVALID_COMMAND:
        add(SpectatorReceiveInvalidCommand(
            message: command.message as PlanningInvalidCommandMessage));
        break;
      case PlanningSpectatorReceiveCommandType.INVALID_SESSION:
        add(SpectatorReceiveInvalidSession());
        break;
      case PlanningSpectatorReceiveCommandType.END_SESSION:
        _sessionEnded = true;
        add(SpectatorReceiveEndSession());
        break;
      case PlanningSpectatorReceiveCommandType.SESSION_IDLE_TIMEOUT:
        add(SpectatorLandingError(
          code: '0007',
          description:
              'The session has been idle for too long and has been terminated.',
        ));
        break;
    }
  }

  _handleStateEvent({required PlanningSessionStateMessage message}) {
    _sessionName = message.sessionName;
    availableCards = message.availableCards;
    ticket = message.ticket;
    password = message.password;

    _sessionJoined = true;
    _timeLeft = message.timeLeft;
  }

  _handleNoneStateEvent(Emitter<SpectatorLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var participantDtos =
        makeParticipantGroupDtos(participants: message.participants);

    emit(SpectatorLandingSessionNone(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: message.coffeeRequestCount,
      spectatorCount: message.spectatorCount,
    ));
  }

  _handleVotingStateEvent(Emitter<SpectatorLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) {
    _handleStateEvent(message: message);
    var ticket = message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: message.participants,
      votes: message.ticket?.ticketVotes,
    );

    emit(SpectatorLandingSessionVoting(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: message.coffeeRequestCount,
      spectatorCount: message.spectatorCount,
      ticket: ticket,
      availableCards: message.availableCards,
    ));
  }

  _handleVotingFinishedStateEvent(Emitter<SpectatorLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) async {
    _handleStateEvent(message: message);
    var ticket = message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: message.participants,
      votes: message.ticket?.ticketVotes,
    );

    var voteGroups = makeGroupedCards(votes: message.ticket?.ticketVotes);

    emit(SpectatorLandingSessionVotingFinished(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: message.coffeeRequestCount,
      spectatorCount: message.spectatorCount,
      ticket: ticket,
      voteGroups: voteGroups,
    ));
  }

  _handleInvalidCommand(Emitter<SpectatorLandingSessionState> emit,
      {required PlanningInvalidCommandMessage message}) {
    emit(SpectatorLandingSessionError(
      sessionName: _sessionName,
      errorCode: message.code,
      errorDescription: message.description,
    ));
  }

  _handleInvalidSessionCommand(Emitter<SpectatorLandingSessionState> emit) {
    emit(SpectatorLandingSessionError(
      sessionName: _sessionName,
      errorCode: '0001',
      errorDescription:
          'The specified session code doesn\'t exist or is no longer available.',
    ));
  }

  _handleEndSessionCommand(Emitter<SpectatorLandingSessionState> emit) =>
      emit(SpectatorLandingSessionEnded(sessionName: _sessionName));

  _sendJoinCommand() async {
    await _localStorageRepository.removeUuid();
    _spectatorSessionRepository.sendJoinSessionCommand(
      uuid: await _uuid,
      sessionCode: sessionCode,
      password: password,
    );
  }

  _sendLeaveSessionCommand() async {
    _sessionEnded = true;
    _spectatorSessionRepository.sendLeaveSessionCommand(uuid: await _uuid);
  }

  _sendReconnectCommand() async {
    await connect();
    if (!_sessionJoined) {
      _sendJoinCommand();
    } else {
      _spectatorSessionRepository.sendReconnectCommand(uuid: await _uuid);
    }
  }
}
