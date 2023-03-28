import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamba/mixins/participants_list_mixin.dart';
import 'package:mamba/mixins/time_left_mixin.dart';
import 'package:mamba/models/commands/spectator/planning_spectator_receive_command.dart';
import 'package:mamba/models/commands/spectator/planning_spectator_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_coffee_vote.dart';
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
    with ParticipantsListMixin, TimeLeftMixin {
  final PlanningSpectatorSessionRepository _spectatorSessionRepository =
      PlanningSpectatorSessionRepository();
  final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();

  String? sessionCode;
  String? password;

  String _sessionName = '';
  List<PlanningCard> availableCards = [];
  Set<String> tags = {};
  PlanningTicket? ticket;
  int? _timeLeft;
  bool _sessionJoined = false;
  bool _sessionEnded = false;

  Future<UuidValue> get _uuid async {
    var localUuid = await _localStorageRepository.getUuid;

    if (localUuid != null) {
      return localUuid;
    } else {
      var uuid = const Uuid().v4obj();
      await _localStorageRepository.uuid(uuid);
      return uuid;
    }
  }

  SpectatorLandingSessionBloc({
    this.sessionCode,
    this.password,
    required bool reconnect,
  }) : super(SpectatorLandingSessionLoading()) {
    _sessionJoined = reconnect;

    // #region Receive command handlers
    on<SpectatorReceiveNoneState>(_handleNoneStateEvent);
    on<SpectatorReceiveVotingState>(_handleVotingStateEvent);
    on<SpectatorReceiveVotingFinishedState>(_handleVotingFinishedStateEvent);
    on<SpectatorReceiveInvalidCommand>(_handleInvalidCommand);
    on<SpectatorReceiveInvalidSession>(_handleInvalidSessionCommand);
    on<SpectatorReceiveEndSession>(_handleEndSessionCommand);
    on<SpectatorReceiveCoffeeVotingState>(_handleCoffeeVotingStateEvent);
    on<SpectatorReceiveCoffeeVotingFinishedState>(
        _handleCoffeeVotingFinishedStateEvent);
    // #endregion

    // #region UI Handlers
    on<SpectatorLandingError>(_handleErrorCommandEvent);
    // #endregion

    // #region Send command handlers
    on<SpectatorSendJoinSession>(_handleSendJoinCommand);
    on<SpectatorSendLeaveSession>(_handleSendLeaveSessionCommand);
    on<SpectatorSendReconnect>(_handleSendReconnectCommand);
    // #endregion
  }

  // #region Base handling functions

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
      case PlanningSpectatorReceiveCommandType.COFFEE_VOTING:
        add(SpectatorReceiveCoffeeVotingState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningSpectatorReceiveCommandType.COFFEE_VOTING_FINISHED:
        add(SpectatorReceiveCoffeeVotingFinishedState(
            message: command.message as PlanningSessionStateMessage));
        break;
    }
  }

  _handleStateEvent({required PlanningSessionStateMessage message}) {
    _sessionName = message.sessionName;
    availableCards = message.availableCards;
    ticket = message.ticket;
    password = message.password;
    sessionCode = message.sessionCode;

    _sessionJoined = true;
    _timeLeft = timeLeft(
      timeReceived: message.updated,
      timeLeft: message.timeLeft,
    );
  }

  // #endregion

  // #region Receive commands handlers

  _handleNoneStateEvent(
    SpectatorReceiveNoneState event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);
    var participantDtos =
        makeParticipantGroupDtos(participants: event.message.participants);

    emit(SpectatorLandingSessionNone(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
    ));
  }

  _handleVotingStateEvent(
    SpectatorReceiveVotingState event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);
    var ticket = event.message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: event.message.participants,
      votes: event.message.ticket?.ticketVotes,
    );

    emit(SpectatorLandingSessionVoting(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      ticket: ticket,
      availableCards: event.message.availableCards,
      timeLeft: _timeLeft,
    ));
  }

  _handleVotingFinishedStateEvent(
    SpectatorReceiveVotingFinishedState event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);
    var ticket = event.message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: event.message.participants,
      votes: event.message.ticket?.ticketVotes,
    );

    var voteGroups = makeGroupedCards(votes: event.message.ticket?.ticketVotes);

    emit(SpectatorLandingSessionVotingFinished(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      ticket: ticket,
      voteGroups: voteGroups,
    ));
  }

  _handleInvalidCommand(
    SpectatorReceiveInvalidCommand event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    emit(SpectatorLandingSessionError(
      sessionName: _sessionName,
      errorCode: event.message.code,
      errorDescription: event.message.description,
    ));
  }

  _handleInvalidSessionCommand(
    SpectatorReceiveInvalidSession event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    emit(SpectatorLandingSessionError(
      sessionName: _sessionName,
      errorCode: '0001',
      errorDescription:
          'The specified session code doesn\'t exist or is no longer available.',
    ));
  }

  _handleEndSessionCommand(
    SpectatorReceiveEndSession event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async =>
      emit(SpectatorLandingSessionEnded(sessionName: _sessionName));

  _handleCoffeeVotingStateEvent(
    SpectatorReceiveCoffeeVotingState event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);

    emit(SpectatorLandingSessionCoffeeVoting(
      sessionName: _sessionName,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      coffeeVotes: event.message.coffeeVotes ?? [],
    ));
  }

  _handleCoffeeVotingFinishedStateEvent(
    SpectatorReceiveCoffeeVotingFinishedState event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);

    emit(SpectatorLandingSessionCoffeeVotingFinished(
      sessionName: _sessionName,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      coffeeVotes: event.message.coffeeVotes ?? [],
    ));
  }

  _handleErrorCommandEvent(
    SpectatorLandingError event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async =>
      emit(SpectatorLandingSessionError(
        sessionName: _sessionName,
        errorCode: event.code,
        errorDescription: event.description,
      ));

  // #endregion

  // #region Send commands handlers

  _handleSendJoinCommand(
    SpectatorSendJoinSession event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async =>
      _sendJoinCommand();

  _sendJoinCommand() async {
    if (sessionCode == null) {
      add(SpectatorLandingError(
        code: '0001',
        description:
            'The session is no longer valid. Please try again from the landing.',
      ));
      return;
    }

    await _localStorageRepository.removeUuid();
    _spectatorSessionRepository.sendJoinSessionCommand(
      uuid: await _uuid,
      sessionCode: sessionCode!,
      password: password,
    );
  }

  _handleSendLeaveSessionCommand(
    SpectatorSendLeaveSession event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    _sessionEnded = true;
    _spectatorSessionRepository.sendLeaveSessionCommand(uuid: await _uuid);
    emit(SpectatorLandingLeftSession(sessionName: _sessionName));
  }

  _handleSendReconnectCommand(
    SpectatorSendReconnect event,
    Emitter<SpectatorLandingSessionState> emit,
  ) async {
    await connect();
    if (!_sessionJoined) {
      _sendJoinCommand();
    } else {
      _spectatorSessionRepository.sendReconnectCommand(uuid: await _uuid);
    }
  }

  // #endregion
}
