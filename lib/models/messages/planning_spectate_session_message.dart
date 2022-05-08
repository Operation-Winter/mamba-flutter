import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/messages/planning_message.dart';
part 'planning_spectate_session_message.g.dart';

@JsonSerializable()
class PlanningSpectateSessionMessage implements PlanningMessage {
  final String sessionCode;
  final String? password;

  PlanningSpectateSessionMessage({
    required this.sessionCode,
    this.password,
  });

  factory PlanningSpectateSessionMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningSpectateSessionMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningSpectateSessionMessageToJson(this);
}
