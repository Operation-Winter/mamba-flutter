import 'package:mamba/models/planning_command.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketNetworking {
  late final WebSocketChannel channel;

  WebSocketNetworking({required Uri uri}) {
    channel = WebSocketChannel.connect(uri);
  }

  void send({required PlanningCommand planningCommand}) {
    var parsedCommand = jsonEncode(planningCommand);
    print(parsedCommand.toString());

    List<int> data = utf8.encode(parsedCommand.toString());
    channel.sink.add(data);
  }

  void close() {
    channel.sink.close();
  }
}
