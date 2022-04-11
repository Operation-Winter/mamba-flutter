import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_previous_tickets_message.g.dart';

@JsonSerializable()
class PlanningPreviousTicketsMessage implements PlanningMessage {
  final List<PlanningTicket> previousTickets;

  PlanningPreviousTicketsMessage({required this.previousTickets});

  factory PlanningPreviousTicketsMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningPreviousTicketsMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningPreviousTicketsMessageToJson(this);
}
