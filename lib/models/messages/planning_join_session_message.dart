class PlanningJoinSessionMessage {
  String sessionCode;
  String participantName;

  PlanningJoinSessionMessage({
    required this.sessionCode,
    required this.participantName,
  });

  factory PlanningJoinSessionMessage.fromJson(dynamic json) {
    return PlanningJoinSessionMessage(
      sessionCode: json['sessionCode'] as String,
      participantName: json['participantName'] as String,
    );
  }
}
