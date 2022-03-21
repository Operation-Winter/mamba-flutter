class PlanningTicketMessage {
  String title;
  String description;

  PlanningTicketMessage({required this.title, required this.description});

  factory PlanningTicketMessage.fromJson(dynamic json) {
    return PlanningTicketMessage(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
