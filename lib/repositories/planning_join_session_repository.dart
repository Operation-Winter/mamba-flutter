import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mamba/models/commands/join/planning_join_receive_command.dart';
import 'package:mamba/models/commands/join/planning_join_send_command.dart';
import 'package:mamba/models/commands/join/planning_join_send_command_type.dart';
import 'package:mamba/models/messages/planning_change_name_message.dart';
import 'package:mamba/models/messages/planning_coffee_vote_message.dart';
import 'package:mamba/models/messages/planning_join_session_message.dart';
import 'package:mamba/models/messages/planning_vote_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/networking/url_center.dart';
import 'package:mamba/networking/web_socket_networking.dart';
import 'package:uuid/uuid.dart';

class PlanningJoinSessionRepository {
  final WebSocketNetworking _webSocket = WebSocketNetworking();

  Future<void> connect() async {
    try {
      await _webSocket.connect(url: URLCenter.planningJoinPath.toString());
    } catch (_) {
      rethrow;
    }
  }

  StreamSubscription? listen(void Function(PlanningJoinReceiveCommand)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _webSocket.listen(
      (event) {
        log(utf8.decode(event));
        PlanningJoinReceiveCommand planningCommand =
            PlanningJoinReceiveCommand.fromJson(jsonDecode(utf8.decode(event)));
        onData?.call(planningCommand);
      },
      onError: onError,
      onDone: onDone,
    );
  }

  void sendJoinSessionCommand({
    required UuidValue uuid,
    required String participantName,
    required String sessionCode,
    String? password,
  }) {
    var message = PlanningJoinSessionMessage(
      participantName: participantName,
      sessionCode: sessionCode,
      password: password,
    );
    var planningCommand = PlanningJoinSendCommand(
      uuid: uuid,
      type: PlanningJoinSendCommandType.JOIN_SESSION,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendVoteCommand({
    required UuidValue uuid,
    required PlanningCard selectedCard,
    String? tag,
  }) {
    var message = PlanningVoteMessage(
      selectedCard: selectedCard,
      tag: tag,
    );
    var planningCommand = PlanningJoinSendCommand(
      uuid: uuid,
      type: PlanningJoinSendCommandType.VOTE,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendLeaveSessionCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningJoinSendCommand(
      uuid: uuid,
      type: PlanningJoinSendCommandType.LEAVE_SESSION,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendReconnectCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningJoinSendCommand(
      uuid: uuid,
      type: PlanningJoinSendCommandType.RECONNECT,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendChangeNameCommand({
    required UuidValue uuid,
    required String name,
  }) {
    var message = PlanningChangeNameMessage(name: name);
    var planningCommand = PlanningJoinSendCommand(
      uuid: uuid,
      type: PlanningJoinSendCommandType.CHANGE_NAME,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendRequestCoffeeBreak({required UuidValue uuid}) {
    var planningCommand = PlanningJoinSendCommand(
      uuid: uuid,
      type: PlanningJoinSendCommandType.REQUEST_COFFEE_BREAK,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendCoffeeBreakVote({
    required UuidValue uuid,
    required bool vote,
  }) {
    var message = PlanningCoffeeVoteMessage(vote: vote);
    var planningCommand = PlanningJoinSendCommand(
      uuid: uuid,
      type: PlanningJoinSendCommandType.COFFEE_BREAK_VOTE,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }
}
