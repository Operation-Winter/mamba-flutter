import 'package:mamba/models/commands/host/planning_host_send_command_type.dart';
import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_host_send_command.g.dart';

@JsonSerializable()
class PlanningHostSendCommand extends PlanningCommand {
  PlanningHostSendCommandType type;

  PlanningMessage? message;

  PlanningHostSendCommand({
    required UuidValue? uuid,
    this.message,
    required this.type,
  }) : super(
          uuid: uuid,
        );

  factory PlanningHostSendCommand.fromJson(Map<String, dynamic> data) =>
      _$PlanningHostSendCommandFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningHostSendCommandToJson(this);
}
