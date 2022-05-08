import 'dart:async';
import 'dart:convert';

import 'package:mamba/models/commands/spectator/planning_spectator_receive_command.dart';
import 'package:mamba/models/commands/spectator/planning_spectator_send_command.dart';
import 'package:mamba/models/commands/spectator/planning_spectator_send_command_type.dart';
import 'package:mamba/models/messages/planning_spectate_session_message.dart';
import 'package:mamba/networking/url_center.dart';
import 'package:mamba/networking/web_socket_wrapper.dart';
import 'package:uuid/uuid.dart';

class PlanningSpectatorSessionRepository {
  final WebSocketNetworking _webSocket = WebSocketNetworking();

  Future<void> connect() async {
    try {
      await _webSocket.connect(url: URLCenter.planningSpectatorPath.toString());
    } catch (_) {
      rethrow;
    }
  }

  StreamSubscription? listen(
      void Function(PlanningSpectatorReceiveCommand)? onData,
      {Function? onError,
      void Function()? onDone,
      bool? cancelOnError}) {
    return _webSocket.webSocket?.listen(
      (event) {
        print(utf8.decode(event));
        PlanningSpectatorReceiveCommand planningCommand =
            PlanningSpectatorReceiveCommand.fromJson(
                jsonDecode(utf8.decode(event)));
        onData?.call(planningCommand);
      },
      onError: onError,
      onDone: onDone,
    );
  }

  void sendJoinSessionCommand({
    required UuidValue uuid,
    required String sessionCode,
    String? password,
  }) {
    var message = PlanningSpectateSessionMessage(
      sessionCode: sessionCode,
      password: password,
    );
    var planningCommand = PlanningSpectatorSendCommand(
      uuid: uuid,
      type: PlanningSpectatorSendCommandType.JOIN_SESSION,
      message: message,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendLeaveSessionCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningSpectatorSendCommand(
      uuid: uuid,
      type: PlanningSpectatorSendCommandType.LEAVE_SESSION,
    );
    _webSocket.send(planningCommand: planningCommand);
  }

  void sendReconnectCommand({
    required UuidValue uuid,
  }) {
    var planningCommand = PlanningSpectatorSendCommand(
      uuid: uuid,
      type: PlanningSpectatorSendCommandType.RECONNECT,
    );
    _webSocket.send(planningCommand: planningCommand);
  }
}
