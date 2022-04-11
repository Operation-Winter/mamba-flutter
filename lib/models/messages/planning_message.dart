import 'package:json_annotation/json_annotation.dart';

part 'planning_message.g.dart';

@JsonSerializable()
class PlanningMessage {
  PlanningMessage();

  factory PlanningMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningMessageToJson(this);
}
