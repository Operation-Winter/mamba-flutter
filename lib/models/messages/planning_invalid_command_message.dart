class PlanningInvalidCommandMessage {
  String code;
  String description;

  PlanningInvalidCommandMessage({
    required this.code,
    required this.description,
  });

  factory PlanningInvalidCommandMessage.fromJson(dynamic json) {
    return PlanningInvalidCommandMessage(
      code: json['code'] as String,
      description: json['description'] as String,
    );
  }
}
