import 'package:json_annotation/json_annotation.dart';
part 'planning_change_name_message.g.dart';

@JsonSerializable()
class PlanningChangeNameMessage {
  String name;

  PlanningChangeNameMessage({required this.name});

  factory PlanningChangeNameMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningChangeNameMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningChangeNameMessageToJson(this);
}
