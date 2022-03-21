import 'package:mamba/models/planning_ticket.dart';

class PlanningChangeNameMessage {
  List<PlanningTicket> previousTickets;

  PlanningChangeNameMessage({required this.previousTickets});

  factory PlanningChangeNameMessage.fromJson(dynamic json) {
    return PlanningChangeNameMessage(
      previousTickets: json['previousTickets'] as List<PlanningTicket>,
    );
  }
}
