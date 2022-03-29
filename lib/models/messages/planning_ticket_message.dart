import 'package:json_annotation/json_annotation.dart';
part 'planning_ticket_message.g.dart';

@JsonSerializable()
class PlanningTicketMessage {
  String title;
  String? description;

  PlanningTicketMessage({required this.title, this.description});

  factory PlanningTicketMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningTicketMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningTicketMessageToJson(this);
}
