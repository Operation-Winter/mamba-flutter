import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/messages/planning_message.dart';
part 'planning_ticket_message.g.dart';

@JsonSerializable()
class PlanningTicketMessage implements PlanningMessage {
  final String title;
  final String? description;

  PlanningTicketMessage({required this.title, this.description});

  factory PlanningTicketMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningTicketMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningTicketMessageToJson(this);
}
