import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mamba/models/planning_command.dart';
import 'package:mamba/networking/websockets/mamba_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BrowserMambaWebSocket implements MambaWebSocket {
  WebSocketChannel? _channel;

  @override
  Future<void> connect({required String url}) async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
    } catch (_) {
      rethrow;
    }
  }

  @override
  void send({required PlanningCommand planningCommand}) {
    var parsedCommand = jsonEncode(planningCommand);
    log(parsedCommand.toString());

    List<int> data = utf8.encode(parsedCommand.toString());
    _channel?.sink.add(data);
  }

  @override
  void close() {
    _channel?.sink.close();
  }

  @override
  StreamSubscription? listen(
    void Function(dynamic onData)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _channel?.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
