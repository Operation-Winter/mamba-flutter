import 'package:mamba/models/commands/join/planning_join_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_join_receive_command.g.dart';

@JsonSerializable()
class PlanningJoinReceiveCommand extends PlanningCommand {
  PlanningJoinReceiveCommandType type;

  PlanningMessage? message;

  PlanningJoinReceiveCommand({
    required UuidValue? uuid,
    this.message,
    required this.type,
  }) : super(
          uuid: uuid,
        );

  factory PlanningJoinReceiveCommand.fromJson(Map<String, dynamic> json) {
    PlanningJoinReceiveCommandType type =
        $enumDecode(_$PlanningJoinReceiveCommandTypeEnumMap, json['type']);
    return PlanningJoinReceiveCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: _parseMessage(type, json['message'] as Map<String, dynamic>?),
      type: type,
    );
  }

  static PlanningMessage? _parseMessage(
      PlanningJoinReceiveCommandType type, Map<String, dynamic>? data) {
    switch (type) {
      case PlanningJoinReceiveCommandType.NONE_STATE:
      case PlanningJoinReceiveCommandType.VOTING_STATE:
      case PlanningJoinReceiveCommandType.FINISHED_STATE:
        if (data == null) return null;
        return PlanningSessionStateMessage.fromJson(data);
      case PlanningJoinReceiveCommandType.INVALID_COMMAND:
        if (data == null) return null;
        return PlanningInvalidCommandMessage.fromJson(data);
      case PlanningJoinReceiveCommandType.INVALID_SESSION:
      case PlanningJoinReceiveCommandType.REMOVE_PARTICIPANT:
      case PlanningJoinReceiveCommandType.END_SESSION:
      case PlanningJoinReceiveCommandType.SESSION_IDLE_TIMEOUT:
        return null;
    }
  }

  @override
  Map<String, dynamic> toJson() => _$PlanningJoinReceiveCommandToJson(this);
}
