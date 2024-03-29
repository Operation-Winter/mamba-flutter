import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mamba/models/commands/host/planning_host_receive_command.dart';
import 'package:mamba/models/commands/host/planning_host_send_command.dart';
import 'package:mamba/models/commands/host/planning_host_send_command_type.dart';
import 'package:mamba/models/messages/planning_add_timer_message.dart';
import 'package:mamba/models/messages/planning_coffee_vote_message.dart';
import 'package:mamba/models/messages/planning_remove_participant_message.dart';
import 'package:mamba/models/messages/planning_skip_vote_message.dart';
import 'package:mamba/models/messages/planning_start_session_message.dart';
import 'package:mamba/models/messages/planning_ticket_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/networking/url_center.dart';
import 'package:mamba/networking/web_socket_networking.dart';
import 'package:uuid/uuid.dart';

class PlanningHostSessionRepository {
  final WebSocketNetworking _webSocket = WebSocketNetworking();

  Future<void> connect() async {
    try {
      await _webSocket.connect(url: URLCenter.planningHostPath.toString());
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  StreamSubscription? listen(void Function(PlanningHostReceiveCommand)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _webSocket.listen(
      (event) {
        log(utf8.decode(event));
        PlanningHostReceiveCommand planningCommand =
            PlanningHostReceiveCommand.fromJson(jsonDecode(utf8.decode(event)));
        onData?.call(planningCommand);
      },
      onError: onError,
      onDone: onDone,
    );
  }

  void sendStartSessionCommand({
    required UuidValue uuid,
    required String sessionName,
    required bool automaticallyCompleteVoting,
    required List<PlanningCard> availableCards,
    String? password,
  }) {
    var message = PlanningStartSessionMessage(
      sessionName: sessionName,
      autoCompleteVoting: automaticallyCompleteVoting,
      availableCards: availableCards,
      password: password,
    );
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.START_SESSION,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendAddTicketCommand({
    required UuidValue uuid,
    required String title,
    String? description,
    required Set<String> selectedTags,
  }) {
    var message = PlanningTicketMessage(
      title: title,
      description: description,
      selectedTags: selectedTags,
    );
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.ADD_TICKET,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendSkipVoteCommand({
    required UuidValue uuid,
    required UuidValue participantId,
  }) {
    var message = PlanningSkipVoteMessage(participantId: participantId);
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.SKIP_VOTE,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendRemoveParticipantCommand({
    required UuidValue uuid,
    required UuidValue participantId,
  }) {
    var message =
        PlanningRemoveParticipantMessage(participantId: participantId);
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.REMOVE_PARTICIPANT,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendEndSessionCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.END_SESSION,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendFinishVotingCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.FINISH_VOTING,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendRevoteCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.REVOTE,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendReconnectCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.RECONNECT,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendEditTicketCommand({
    required UuidValue uuid,
    required String title,
    String? description,
    required Set<String> selectedTags,
  }) {
    var message = PlanningTicketMessage(
      title: title,
      description: description,
      selectedTags: selectedTags,
    );
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.ADD_TICKET,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendAddTimerCommand({
    required UuidValue uuid,
    required int timeInterval,
  }) {
    var message = PlanningAddTimerMessage(time: timeInterval);
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.ADD_TIMER,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendCancelTimerCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.CANCEL_TIMER,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendPreviousTicketsCommand({required UuidValue uuid}) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.PREVIOUS_TICKETS,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendRequestCoffeeBreak({required UuidValue uuid}) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.REQUEST_COFFEE_BREAK,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendStartCoffeeBreakVote({required UuidValue uuid}) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.START_COFFEE_BREAK_VOTE,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendFinishCoffeeBreakVote({required UuidValue uuid}) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.FINISH_COFFEE_BREAK_VOTE,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendEndCoffeeBreakVote({required UuidValue uuid}) {
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.END_COFFEE_BREAK_VOTE,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendCoffeeBreakVote({required UuidValue uuid, required bool vote}) {
    var message = PlanningCoffeeVoteMessage(vote: vote);
    var planningCommand = PlanningHostSendCommand(
      uuid: uuid,
      type: PlanningHostSendCommandType.COFFEE_BREAK_VOTE,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }
}
