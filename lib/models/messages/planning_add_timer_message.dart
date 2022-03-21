class PlanningAddTimerMessage {
  int timeInterval;

  PlanningAddTimerMessage({required this.timeInterval});

  factory PlanningAddTimerMessage.fromJson(dynamic json) {
    return PlanningAddTimerMessage(
      timeInterval: json['timeInterval'] as int,
    );
  }
}
