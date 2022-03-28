import 'package:json_annotation/json_annotation.dart';
part 'planning_join_session_message.g.dart';

@JsonSerializable()
class PlanningJoinSessionMessage {
  String sessionCode;
  String participantName;

  PlanningJoinSessionMessage({
    required this.sessionCode,
    required this.participantName,
  });

  factory PlanningJoinSessionMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningJoinSessionMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningJoinSessionMessageToJson(this);
}
