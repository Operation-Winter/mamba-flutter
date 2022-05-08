import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:mamba/networking/websockets/browser_mamba_web_socket.dart';
import 'package:mamba/networking/websockets/mamba_web_socket.dart';
import 'package:mamba/networking/websockets/native_mamba_web_socket.dart';

class WebSocketNetworking implements MambaWebSocket {
  late MambaWebSocket mambaWebSocket;

  WebSocketNetworking() {
    mambaWebSocket = kIsWeb ? BrowserMambaWebSocket() : NativeMambaWebSocket();
  }

  @override
  Future<void> connect({required String url}) =>
      mambaWebSocket.connect(url: url);

  @override
  StreamSubscription? listen(void Function(dynamic onData)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      mambaWebSocket.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  @override
  void send({required PlanningCommand planningCommand}) =>
      mambaWebSocket.send(planningCommand: planningCommand);

  @override
  void close() => mambaWebSocket.close();
}
