class PlanningChangeNameMessage {
  String name;

  PlanningChangeNameMessage({required this.name});

  factory PlanningChangeNameMessage.fromJson(dynamic json) {
    return PlanningChangeNameMessage(
      name: json['name'] as String,
    );
  }
}
