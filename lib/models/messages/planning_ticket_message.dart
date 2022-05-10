import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/messages/planning_message.dart';
part 'planning_ticket_message.g.dart';

@JsonSerializable()
class PlanningTicketMessage implements PlanningMessage {
  final String title;
  final String? description;
  final Set<String> selectedTags;

  PlanningTicketMessage({
    required this.title,
    this.description,
    required this.selectedTags,
  });

  factory PlanningTicketMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningTicketMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningTicketMessageToJson(this);
}
