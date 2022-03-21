import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_ticket.dart';

class PlanningSessionStateMessage {
  String sessionCode;
  String sessionName;
  List<PlanningCard> availableCards;
  List<PlanningParticipant> participants;
  PlanningTicket? ticket;
  int? timeLeft;

  PlanningSessionStateMessage({
    required this.sessionCode,
    required this.sessionName,
    required this.availableCards,
    required this.participants,
    this.ticket,
    this.timeLeft,
  });

  factory PlanningSessionStateMessage.fromJson(dynamic json) {
    return PlanningSessionStateMessage(
      sessionCode: json['sessionCode'] as String,
      sessionName: json['sessionCode'] as String,
      availableCards: json['availableCards'] as List<PlanningCard>,
      participants: json['participants'] as List<PlanningParticipant>,
      ticket: json['ticket'] as PlanningTicket?,
      timeLeft: json['timeLeft'] as int?,
    );
  }
}
