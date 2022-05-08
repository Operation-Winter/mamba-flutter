import 'package:mamba/models/commands/spectator/planning_spectator_send_command_type.dart';
import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_spectator_send_command.g.dart';

@JsonSerializable()
class PlanningSpectatorSendCommand extends PlanningCommand {
  PlanningSpectatorSendCommandType type;

  PlanningMessage? message;

  PlanningSpectatorSendCommand({
    required UuidValue? uuid,
    this.message,
    required this.type,
  }) : super(
          uuid: uuid,
        );

  factory PlanningSpectatorSendCommand.fromJson(Map<String, dynamic> data) =>
      _$PlanningSpectatorSendCommandFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningSpectatorSendCommandToJson(this);
}
