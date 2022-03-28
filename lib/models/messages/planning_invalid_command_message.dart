import 'package:json_annotation/json_annotation.dart';
part 'planning_invalid_command_message.g.dart';

@JsonSerializable()
class PlanningInvalidCommandMessage {
  String code;
  String description;

  PlanningInvalidCommandMessage({
    required this.code,
    required this.description,
  });

  factory PlanningInvalidCommandMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningInvalidCommandMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningInvalidCommandMessageToJson(this);
}
