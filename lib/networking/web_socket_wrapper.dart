import 'package:mamba/models/planning_command.dart';
import 'package:universal_io/io.dart';
import 'dart:convert';

class WebSocketNetworking {
  WebSocket? webSocket;

  Future<void> connect({required String url}) async {
    try {
      webSocket = await WebSocket.connect(url);
      webSocket?.pingInterval = const Duration(seconds: 15);
    } catch (_) {
      rethrow;
    }
  }

  void send({required PlanningCommand planningCommand}) {
    var parsedCommand = jsonEncode(planningCommand);
    print(parsedCommand.toString());

    List<int> data = utf8.encode(parsedCommand.toString());
    webSocket?.add(data);
  }

  void close() {
    webSocket?.close();
  }
}
