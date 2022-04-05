import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command_type.dart';
import 'package:mamba/models/messages/planning_invalid_command_message.dart';
import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/messages/planning_previous_tickets_message.dart';
import 'package:mamba/models/messages/planning_session_state_message.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:uuid/uuid.dart';
part 'planning_host_receive_command.g.dart';

@JsonSerializable()
class PlanningHostReceiveCommand extends PlanningCommand {
  PlanningHostReceiveCommandType type;

  PlanningMessage? message;

  PlanningHostReceiveCommand({
    required UuidValue? uuid,
    this.message,
    required this.type,
  }) : super(
          uuid: uuid,
        );

  factory PlanningHostReceiveCommand.fromJson(Map<String, dynamic> json) {
    PlanningHostReceiveCommandType type =
        $enumDecode(_$PlanningHostReceiveCommandTypeEnumMap, json['type']);
    return PlanningHostReceiveCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: _parseMessage(type, json['message'] as Map<String, dynamic>),
      type: type,
    );
  }

  static PlanningMessage? _parseMessage(
      PlanningHostReceiveCommandType type, Map<String, dynamic> data) {
    switch (type) {
      case PlanningHostReceiveCommandType.NONE_STATE:
      case PlanningHostReceiveCommandType.VOTING_STATE:
      case PlanningHostReceiveCommandType.FINISHED_STATE:
        return PlanningSessionStateMessage.fromJson(data);
      case PlanningHostReceiveCommandType.INVALID_COMMAND:
        return PlanningInvalidCommandMessage.fromJson(data);
      case PlanningHostReceiveCommandType.PREVIOUS_TICKETS:
        return PlanningPreviousTicketsMessage.fromJson(data);
    }
  }

  @override
  Map<String, dynamic> toJson() => _$PlanningHostReceiveCommandToJson(this);
}
