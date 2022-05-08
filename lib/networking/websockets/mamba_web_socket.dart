import 'dart:async';

import 'package:mamba/models/planning_command.dart';

abstract class MambaWebSocket {
  Future<void> connect({required String url});

  void send({required PlanningCommand planningCommand});

  StreamSubscription? listen(
    void Function(dynamic onData)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });

  void close();
}
