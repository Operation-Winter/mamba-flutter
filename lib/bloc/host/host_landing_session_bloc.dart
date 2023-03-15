import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamba/mixins/participants_list_mixin.dart';
import 'package:mamba/mixins/voting_results_mixin.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_previous_tickets_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_coffee_vote.dart';
import 'package:mamba/models/planning_participant_group_dto.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/repositories/local_storage_repository.dart';
import 'package:mamba/repositories/planning_host_session_repository.dart';
import 'package:meta/meta.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

part 'host_landing_session_event.dart';
part 'host_landing_session_state.dart';

class HostLandingSessionBloc
    extends Bloc<HostLandingSessionEvent, HostLandingSessionState>
    with ParticipantsListMixin, VotingResultsMixin {
  late final PlanningHostSessionRepository _hostSessionRepository =
      PlanningHostSessionRepository();
  late final LocalStorageRepository _localStorageRepository =
      LocalStorageRepository();
  bool _sessionHasStarted = false;
  bool _sessionEnded = false;
  int _coffeeRequestCount = 0;

  bool coffeeBannerDismissed = false;
  String sessionName;
  String? sessionCode;
  String? password;
  bool automaticallyCompleteVoting;
  List<PlanningCard> availableCards;
  Set<String> tags = {};
  PlanningTicket? ticket;

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

  int? _timeLeft;

  HostLandingSessionBloc({
    required this.sessionName,
    this.password,
    required this.availableCards,
    required this.automaticallyCompleteVoting,
    required bool reconnect,
  }) : super(HostLandingSessionLoading()) {
    _sessionHasStarted = reconnect;

    // #region Receive commands

    on<HostReceiveNoneState>(_handleNoneStateEvent);
    on<HostReceiveVotingState>(_handleVotingStateEvent);
    on<HostReceiveVotingFinishedState>(_handleVotingFinishedStateEvent);
    on<HostReceiveInvalidCommand>(_handleInvalidCommand);
    on<HostReceivePreviousTickets>(_handleReceivePreviousTicketsEvent);
    on<HostLandingError>(_handleReceiveLandingError);
    on<HostReceiveCoffeeVotingState>(_handleCoffeeVotingStateEvent);
    on<HostReceiveCoffeeVotingFinishedState>(
        _handleCoffeeVotingFinishedStateEvent);
    // #endregion

    // #region Send commands

    on<HostSendStartSession>(_handleSendStartCommand);
    on<HostSendAddTicket>(_handleSendAddTicketCommand);
    on<HostSendSkipVote>(_handleSendSkipVoteCommand);
    on<HostSendRemoveParticipant>(_handleSendRemoveParticipantCommand);
    on<HostSendEndSession>(_handleSendEndSessionCommand);
    on<HostSendFinishVoting>(_handleSendFinishVotingCommand);
    on<HostSendRevote>(_handleSendRevoteCommand);
    on<HostSendReconnect>(_handleSendReconnectCommand);
    on<HostSendEditTicket>(_handleSendEditTicketCommand);
    on<HostSendAddTimer>(_handleSendAddTimerCommand);
    on<HostSendCancelTimer>(_handleSendCancelTimerCommand);
    on<HostSendPreviousTickets>(_handleSendPreviousTicketsCommand);
    on<HostSendRequestCoffeeBreak>(_handleSendRequestCoffeeBreakCommand);
    on<HostSendCoffeeVote>(_handleSendCoffeeVoteCommand);
    on<HostSendFinishCoffeeVote>(_handleSendFinishCoffeeVoteCommand);
    on<HostSendEndCoffeeVote>(_handleSendEndCoffeeVoteCommand);
    on<HostSendStartCoffeeVote>(_handleSendStartCoffeeVoteCommand);

    // #endregion
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
        add(HostReceivePreviousTickets(
            message: command.message as PlanningPreviousTicketsMessage));
        break;
      case PlanningHostReceiveCommandType.SESSION_IDLE_TIMEOUT:
        add(HostLandingError(
          code: '0007',
          description:
              'The session has been idle for too long and has been terminated.',
        ));
        break;
      case PlanningHostReceiveCommandType.COFFEE_VOTING:
        add(HostReceiveCoffeeVotingState(
            message: command.message as PlanningSessionStateMessage));
        break;
      case PlanningHostReceiveCommandType.COFFEE_VOTING_FINISHED:
        add(HostReceiveCoffeeVotingFinishedState(
            message: command.message as PlanningSessionStateMessage));
        break;
    }
  }

  // #region Handle incoming events

  _handleStateEvent(Emitter<HostLandingSessionState> emit,
      {required PlanningSessionStateMessage message}) {
    sessionName = message.sessionName;
    availableCards = message.availableCards;
    ticket = message.ticket;
    sessionCode = message.sessionCode;
    password = message.password;

    _sessionHasStarted = true;
    _timeLeft = message.timeLeft;

    if (_coffeeRequestCount != message.coffeeRequestCount) {
      coffeeBannerDismissed = false;
    }
    _coffeeRequestCount = message.coffeeRequestCount;

    if (!coffeeBannerDismissed &&
        message.participants.isNotEmpty &&
        _coffeeRequestCount >= (message.participants.length / 2)) {
      emit(HostLandingSessionBanner(
        title:
            'At least half of the participants have requested for a coffee break!',
      ));
    }
  }

  _handleNoneStateEvent(
    HostReceiveNoneState event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    _handleStateEvent(emit, message: event.message);
    var participantDtos =
        makeParticipantGroupDtos(participants: event.message.participants);

    emit(HostLandingSessionNone(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
    ));
  }

  _handleVotingStateEvent(
    HostReceiveVotingState event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    _handleStateEvent(emit, message: event.message);
    var ticket = event.message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: event.message.participants,
      votes: event.message.ticket?.ticketVotes,
    );

    emit(HostLandingSessionVoting(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      ticket: ticket,
    ));
  }

  _handleVotingFinishedStateEvent(
    HostReceiveVotingFinishedState event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    _handleStateEvent(emit, message: event.message);
    var ticket = event.message.ticket;
    if (ticket == null) return;

    var participantDtos = makeParticipantGroupDtos(
      participants: event.message.participants,
      votes: event.message.ticket?.ticketVotes,
    );

    var voteGroups = makeGroupedCards(votes: event.message.ticket?.ticketVotes);

    emit(HostLandingSessionVotingFinished(
      sessionName: sessionName,
      participants: participantDtos,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      ticket: ticket,
      voteGroups: voteGroups,
    ));
  }

  _handleCoffeeVotingStateEvent(
    HostReceiveCoffeeVotingState event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    _handleStateEvent(emit, message: event.message);
    var hostUuid = await _uuid;
    var vote = event.message.coffeeVotes
        ?.firstWhereOrNull((element) => element.participantId == hostUuid)
        ?.vote;
    emit(HostLandingSessionCoffeeVoting(
      sessionName: sessionName,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      vote: vote,
      coffeeVotes: event.message.coffeeVotes ?? [],
    ));
  }

  _handleCoffeeVotingFinishedStateEvent(
    HostReceiveCoffeeVotingFinishedState event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    _handleStateEvent(emit, message: event.message);

    emit(HostLandingSessionCoffeeVotingFinished(
      sessionName: sessionName,
      coffeeVoteCount: event.message.coffeeRequestCount,
      spectatorCount: event.message.spectatorCount,
      coffeeVotes: event.message.coffeeVotes ?? [],
    ));
  }

  _handleInvalidCommand(
    HostReceiveInvalidCommand event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      emit(HostLandingSessionError(
        sessionName: sessionName,
        errorCode: event.message.code,
        errorDescription: event.message.description,
      ));

  _handleReceivePreviousTicketsEvent(
    HostReceivePreviousTickets event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    var csvContent = _makePreviousTicketsCsvContents(
        previousTickets: event.message.previousTickets);
    final fileName = 'Mamba - ${sessionName.replaceAll(RegExp(r'\W '), '')}';

    Uint8List bytes = Uint8List.fromList(utf8.encode(csvContent));
    var csvFile = XFile.fromData(
      bytes,
      length: bytes.length,
      lastModified: DateTime.now(),
      mimeType: 'text/csv',
      name: '$fileName.csv',
    );

    emit(HostLandingSessionPreviousTickets(file: csvFile));
  }

  String _makePreviousTicketsCsvContents(
      {required List<PlanningTicket> previousTickets}) {
    List<List<String>> csvContents = [
      ['ID', 'Title', 'Description', 'Tag', 'Final sizing', 'Vote count'],
    ];

    previousTickets.forEachIndexed((ticketIndex, ticket) {
      var tagGroups = makeGroupedCards(votes: ticket.ticketVotes);
      var voteGroups = makeVotingResults(voteGroups: tagGroups);

      var results = tagGroups.mapIndexed((index, tagGroup) {
        var tag =
            voteGroups.firstWhereOrNull((group) => group.tag == tagGroup.tag);
        var cardTitle = tag?.graphData.firstOrNull?.title ?? '-';
        var voteCount = tag?.graphData.map((e) => e.ratio).sum ?? 0;

        return [
          '${ticketIndex + 1}',
          index == 0 ? ticket.title : '',
          index == 0 ? ticket.description ?? '' : '',
          tagGroup.tag ?? '-',
          cardTitle,
          '$voteCount',
        ];
      });

      csvContents.addAll(results);
    });

    return const ListToCsvConverter().convert(csvContents);
  }

  _handleReceiveLandingError(
    HostLandingError event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      emit(HostLandingSessionError(
        sessionName: sessionName,
        errorCode: event.code,
        errorDescription: event.description,
      ));

  // #endregion

  // #region Send commands

  _handleSendStartCommand(
    HostSendStartSession event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      await _sendStartCommand();

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

  _handleSendAddTicketCommand(
    HostSendAddTicket event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    tags = event.tags;
    _hostSessionRepository.sendAddTicketCommand(
      uuid: await _uuid,
      title: event.title,
      description: event.description,
      selectedTags: event.selectedTags,
    );
  }

  _handleSendSkipVoteCommand(
    HostSendSkipVote event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendSkipVoteCommand(
        uuid: await _uuid,
        participantId: event.participantId,
      );

  _handleSendRemoveParticipantCommand(
    HostSendRemoveParticipant event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendRemoveParticipantCommand(
        uuid: await _uuid,
        participantId: event.participantId,
      );

  _handleSendEndSessionCommand(
    HostSendEndSession event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    _hostSessionRepository.sendEndSessionCommand(uuid: await _uuid);
    _sessionEnded = true;
    emit(HostLandingSessionEnded(sessionName: sessionName));
  }

  _handleSendFinishVotingCommand(
    HostSendFinishVoting event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendFinishVotingCommand(uuid: await _uuid);

  _handleSendRevoteCommand(
    HostSendRevote event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendRevoteCommand(uuid: await _uuid);

  _handleSendReconnectCommand(
    HostSendReconnect event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    await connect();
    if (!_sessionHasStarted) {
      await _sendStartCommand();
    } else {
      _hostSessionRepository.sendReconnectCommand(uuid: await _uuid);
    }
  }

  _handleSendEditTicketCommand(
    HostSendEditTicket event,
    Emitter<HostLandingSessionState> emit,
  ) async {
    tags = event.tags;
    _hostSessionRepository.sendEditTicketCommand(
      uuid: await _uuid,
      title: event.title,
      description: event.description,
      selectedTags: event.selectedTags,
    );
  }

  _handleSendAddTimerCommand(
    HostSendAddTimer event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendAddTimerCommand(
        uuid: await _uuid,
        timeInterval: event.timeInterval,
      );

  _handleSendCancelTimerCommand(
    HostSendCancelTimer event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendCancelTimerCommand(uuid: await _uuid);

  _handleSendPreviousTicketsCommand(
    HostSendPreviousTickets event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendPreviousTicketsCommand(uuid: await _uuid);

  _handleSendRequestCoffeeBreakCommand(
    HostSendRequestCoffeeBreak event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendRequestCoffeeBreak(uuid: await _uuid);

  _handleSendStartCoffeeVoteCommand(
    HostSendStartCoffeeVote event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendStartCoffeeBreakVote(uuid: await _uuid);

  _handleSendFinishCoffeeVoteCommand(
    HostSendFinishCoffeeVote event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendFinishCoffeeBreakVote(uuid: await _uuid);

  _handleSendEndCoffeeVoteCommand(
    HostSendEndCoffeeVote event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendEndCoffeeBreakVote(uuid: await _uuid);

  _handleSendCoffeeVoteCommand(
    HostSendCoffeeVote event,
    Emitter<HostLandingSessionState> emit,
  ) async =>
      _hostSessionRepository.sendCoffeeBreakVote(
        uuid: await _uuid,
        vote: event.vote,
      );

  // #endregion
}
