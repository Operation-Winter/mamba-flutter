import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamba/mixins/participants_list_mixin.dart';
import 'package:mamba/models/commands/join/planning_join_receive_command.dart';
import 'package:mamba/models/commands/join/planning_join_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_coffee_vote.dart';
import 'package:mamba/models/planning_participant_group_dto.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/repositories/local_storage_repository.dart';
import 'package:mamba/repositories/planning_join_session_repository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

part 'join_landing_session_event.dart';
part 'join_landing_session_state.dart';

class JoinLandingSessionBloc
    extends Bloc<JoinLandingSessionEvent, JoinLandingSessionState>
    with ParticipantsListMixin {
  late final PlanningJoinSessionRepository _joinSessionRepository =
      PlanningJoinSessionRepository();
  late final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();

  String? sessionCode;
  String? password;
  String username;

  String _sessionName = '';
  List<PlanningCard> availableCards = [];
  Set<String> tags = {};
  PlanningTicket? ticket;
  int? _timeLeft;
  bool _sessionJoined = false;
  bool _sessionEnded = false;
  String? _selectedTag;

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

  JoinLandingSessionBloc({
    this.sessionCode,
    this.password,
    required this.username,
    required bool reconnect,
  }) : super(JoinLandingSessionLoading()) {
    _sessionJoined = reconnect;

    // #region Send commands
    on<JoinSendJoinSession>(_handleSendJoinCommand);
    on<JoinSendLeaveSession>(_handleSendLeaveSessionCommand);
    on<JoinSendReconnect>(_handleSendReconnectCommand);
    on<JoinSendRequestCoffeeBreak>(_handleSendRequestCoffeeBreakCommand);
    on<JoinSendChangeName>(_handleSendChangeNameCommand);
    on<JoinSendVote>(_handleSendVoteCommand);
    on<JoinSendCoffeeBreakVote>(_handleSendCoffeeBreakVoteCommand);
    // #endregion

    // #region Receive commands
    on<JoinReceiveNoneState>(_handleNoneStateEvent);
    on<JoinReceiveVotingState>(_handleVotingStateEvent);
    on<JoinReceiveVotingFinishedState>(_handleVotingFinishedStateEvent);
    on<JoinReceiveInvalidCommand>(_handleInvalidCommand);
    on<JoinReceiveInvalidSession>(_handleInvalidSessionCommand);
    on<JoinReceiveRemoveParticipant>(_handleRemoveParticipantCommand);
    on<JoinReceiveEndSession>(_handleEndSessionCommand);
    on<JoinReceiveCoffeeVotingState>(_handleCoffeeVotingStateEvent);
    on<JoinReceiveCoffeeVotingFinishedState>(
        _handleCoffeeVotingFinishedStateEvent);
    // #endregion

    // #region UI Events
    on<JoinLandingError>(_handleLandingError);
    on<JoinDidSelectTag>(_handleDidSelectTag);
    // #endregion
  }

  // #region Base handling functions

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
      case PlanningJoinReceiveCommandType.SESSION_IDLE_TIMEOUT:
        add(JoinLandingError(
          code: '0007',
          description:
              'The session has been idle for too long and has been terminated.',
        ));
        break;
      case PlanningJoinReceiveCommandType.COFFEE_VOTING:
        add(JoinReceiveCoffeeVotingState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningJoinReceiveCommandType.COFFEE_VOTING_FINISHED:
        add(JoinReceiveCoffeeVotingFinishedState(
            message: command.message as PlanningSessionStateMessage));
        break;
    }
  }

  _handleStateEvent({required PlanningSessionStateMessage message}) async {
    sessionCode = message.sessionCode;
    _sessionName = message.sessionName;
    availableCards = message.availableCards;
    ticket = message.ticket;
    password = message.password;

    _timeLeft = message.timeLeft;

    var participantUuid = await _uuid;
    if (username == 'Unknown') {
      username = message.participants
              .firstWhereOrNull(
                  (participant) => participant.participantId == participantUuid)
              ?.name ??
          'Unknown';
    }
  }

  // #endregion

  // #region Receive commands

  _handleNoneStateEvent(
    JoinReceiveNoneState event,
    Emitter<JoinLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);
    var participantDtos =
        makeParticipantGroupDtos(participants: event.message.participants);

    emit(JoinLandingSessionNone(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
    ));
  }

  _handleVotingStateEvent(
    JoinReceiveVotingState event,
    Emitter<JoinLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);
    var ticket = event.message.ticket;
    if (ticket == null) return;

    var uuid = await _uuid;
    var selectedCard = ticket.ticketVotes
        .firstWhereOrNull((element) => element.participantId == uuid)
        ?.selectedCard;

    var participantDtos = makeParticipantGroupDtos(
      participants: event.message.participants,
      votes: event.message.ticket?.ticketVotes,
    );

    emit(JoinLandingSessionVoting(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      ticket: ticket,
      availableCards: event.message.availableCards,
      selectedCard: selectedCard,
      selectedTag: _selectedTag,
      timeLeft: _timeLeft,
    ));
  }

  _handleVotingFinishedStateEvent(
    JoinReceiveVotingFinishedState event,
    Emitter<JoinLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);
    var ticket = event.message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: event.message.participants,
      votes: event.message.ticket?.ticketVotes,
    );

    var voteGroups = makeGroupedCards(votes: event.message.ticket?.ticketVotes);

    emit(JoinLandingSessionVotingFinished(
      sessionName: _sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      ticket: ticket,
      voteGroups: voteGroups,
    ));
  }

  _handleInvalidCommand(
    JoinReceiveInvalidCommand event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      emit(JoinLandingSessionError(
        sessionName: _sessionName,
        errorCode: event.message.code,
        errorDescription: event.message.description,
      ));

  _handleInvalidSessionCommand(
    JoinReceiveInvalidSession event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      emit(JoinLandingSessionError(
        sessionName: _sessionName,
        errorCode: '0001',
        errorDescription:
            'The specified session code doesn\'t exist or is no longer available.',
      ));

  _handleRemoveParticipantCommand(
    JoinReceiveRemoveParticipant event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      emit(JoinLandingRemovedFromSession(sessionName: _sessionName));

  _handleEndSessionCommand(
    JoinReceiveEndSession event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      emit(JoinLandingSessionEnded(sessionName: _sessionName));

  // #endregion

  // #region UI Events

  _handleLandingError(
    JoinLandingError event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      emit(JoinLandingSessionError(
        sessionName: _sessionName,
        errorCode: event.code,
        errorDescription: event.description,
      ));

  _handleDidSelectTag(
    JoinDidSelectTag event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      _selectedTag = event.tag;

  _handleCoffeeVotingStateEvent(
    JoinReceiveCoffeeVotingState event,
    Emitter<JoinLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);
    var participantUuid = await _uuid;
    var vote = event.message.coffeeVotes
        ?.firstWhereOrNull(
            (element) => element.participantId == participantUuid)
        ?.vote;
    emit(JoinLandingSessionCoffeeVoting(
      sessionName: _sessionName,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      vote: vote,
      coffeeVotes: event.message.coffeeVotes ?? [],
    ));
  }

  _handleCoffeeVotingFinishedStateEvent(
    JoinReceiveCoffeeVotingFinishedState event,
    Emitter<JoinLandingSessionState> emit,
  ) async {
    _handleStateEvent(message: event.message);

    emit(JoinLandingSessionCoffeeVotingFinished(
      sessionName: _sessionName,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      coffeeVotes: event.message.coffeeVotes ?? [],
    ));
  }

  // #endregion

  // #region Send commands

  _handleSendJoinCommand(
    JoinSendJoinSession event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      _sendJoinCommand();

  _sendJoinCommand() async {
    if (sessionCode == null) {
      add(JoinLandingError(
        code: '0001',
        description:
            'The session is no longer valid. Please try again from the landing.',
      ));
      return;
    }

    await _localStorageRepository.removeUuid();
    await _localStorageRepository.username(username);
    _joinSessionRepository.sendJoinSessionCommand(
      uuid: await _uuid,
      participantName: username,
      sessionCode: sessionCode!,
      password: password,
    );
  }

  _handleSendChangeNameCommand(
    JoinSendChangeName event,
    Emitter<JoinLandingSessionState> emit,
  ) async {
    username = event.newUsername;
    await _localStorageRepository.username(username);
    _joinSessionRepository.sendChangeNameCommand(
        uuid: await _uuid, name: username);
  }

  _handleSendVoteCommand(
    JoinSendVote event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      _joinSessionRepository.sendVoteCommand(
        uuid: await _uuid,
        selectedCard: event.selectedCard,
        tag: event.tag,
      );

  _handleSendLeaveSessionCommand(
    JoinSendLeaveSession event,
    Emitter<JoinLandingSessionState> emit,
  ) async {
    _sessionEnded = true;
    _joinSessionRepository.sendLeaveSessionCommand(uuid: await _uuid);
    emit(JoinLandingLeftSession(sessionName: _sessionName));
  }

  _handleSendReconnectCommand(
    JoinSendReconnect event,
    Emitter<JoinLandingSessionState> emit,
  ) async {
    await connect();

    if (!_sessionJoined) {
      _sendJoinCommand();
    } else {
      _joinSessionRepository.sendReconnectCommand(uuid: await _uuid);
    }
  }

  _handleSendRequestCoffeeBreakCommand(
    JoinSendRequestCoffeeBreak event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      _joinSessionRepository.sendRequestCoffeeBreak(uuid: await _uuid);

  _handleSendCoffeeBreakVoteCommand(
    JoinSendCoffeeBreakVote event,
    Emitter<JoinLandingSessionState> emit,
  ) async =>
      _joinSessionRepository.sendCoffeeBreakVote(
        uuid: await _uuid,
        vote: event.vote,
      );

  // #endregion
}
