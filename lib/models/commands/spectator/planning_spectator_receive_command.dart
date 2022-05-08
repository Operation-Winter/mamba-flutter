import 'package:mamba/models/commands/spectator/planning_spectator_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_spectator_receive_command.g.dart';

@JsonSerializable()
class PlanningSpectatorReceiveCommand extends PlanningCommand {
  PlanningSpectatorReceiveCommandType type;

  PlanningMessage? message;

  PlanningSpectatorReceiveCommand({
    required UuidValue? uuid,
    this.message,
    required this.type,
  }) : super(
          uuid: uuid,
        );

  factory PlanningSpectatorReceiveCommand.fromJson(Map<String, dynamic> json) {
    PlanningSpectatorReceiveCommandType type =
        $enumDecode(_$PlanningSpectatorReceiveCommandTypeEnumMap, json['type']);
    return PlanningSpectatorReceiveCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: _parseMessage(type, json['message'] as Map<String, dynamic>?),
      type: type,
    );
  }

  static PlanningMessage? _parseMessage(
      PlanningSpectatorReceiveCommandType type, Map<String, dynamic>? data) {
    switch (type) {
      case PlanningSpectatorReceiveCommandType.NONE_STATE:
      case PlanningSpectatorReceiveCommandType.VOTING_STATE:
      case PlanningSpectatorReceiveCommandType.FINISHED_STATE:
        if (data == null) return null;
        return PlanningSessionStateMessage.fromJson(data);
      case PlanningSpectatorReceiveCommandType.INVALID_COMMAND:
        if (data == null) return null;
        return PlanningInvalidCommandMessage.fromJson(data);
      case PlanningSpectatorReceiveCommandType.INVALID_SESSION:
      case PlanningSpectatorReceiveCommandType.END_SESSION:
      case PlanningSpectatorReceiveCommandType.SESSION_IDLE_TIMEOUT:
        return null;
    }
  }

  @override
  Map<String, dynamic> toJson() =>
      _$PlanningSpectatorReceiveCommandToJson(this);
}
