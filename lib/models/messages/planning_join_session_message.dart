import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/messages/planning_message.dart';
part 'planning_join_session_message.g.dart';

@JsonSerializable()
class PlanningJoinSessionMessage implements PlanningMessage {
  final String sessionCode;
  final String participantName;
  final String? password;

  PlanningJoinSessionMessage({
    required this.sessionCode,
    required this.participantName,
    this.password,
  });

  factory PlanningJoinSessionMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningJoinSessionMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningJoinSessionMessageToJson(this);
}
