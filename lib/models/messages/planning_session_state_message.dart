import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_session_state_message.g.dart';

@JsonSerializable()
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

  factory PlanningSessionStateMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningSessionStateMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningSessionStateMessageToJson(this);
}
