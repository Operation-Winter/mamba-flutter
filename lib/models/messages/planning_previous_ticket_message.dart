import 'package:mamba/models/planning_ticket.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_previous_ticket_message.g.dart';

@JsonSerializable()
class PlanningPreviousTicketMessage {
  List<PlanningTicket> previousTickets;

  PlanningPreviousTicketMessage({required this.previousTickets});

  factory PlanningPreviousTicketMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningPreviousTicketMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningPreviousTicketMessageToJson(this);
}
