import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/messages/planning_message.dart';
part 'planning_invalid_command_message.g.dart';

@JsonSerializable()
class PlanningInvalidCommandMessage implements PlanningMessage {
  final String code;
  final String description;

  PlanningInvalidCommandMessage({
    required this.code,
    required this.description,
  });

  factory PlanningInvalidCommandMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningInvalidCommandMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningInvalidCommandMessageToJson(this);
}
