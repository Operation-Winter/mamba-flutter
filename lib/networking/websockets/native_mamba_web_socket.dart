import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mamba/models/planning_command.dart';
import 'package:mamba/networking/websockets/mamba_web_socket.dart';
import 'package:universal_io/io.dart';

class NativeMambaWebSocket implements MambaWebSocket {
  WebSocket? webSocket;

  @override
  Future<void> connect({required String url}) async {
    try {
      webSocket = await WebSocket.connect(url);
      webSocket?.pingInterval = const Duration(seconds: 5);
    } catch (_) {
      rethrow;
    }
  }

  @override
  void send({required PlanningCommand planningCommand}) {
    var parsedCommand = jsonEncode(planningCommand);
    log(parsedCommand.toString());

    List<int> data = utf8.encode(parsedCommand.toString());
    webSocket?.add(data);
  }

  @override
  void close() {
    webSocket?.close();
  }

  @override
  StreamSubscription? listen(
    void Function(dynamic onData)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      webSocket?.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}
