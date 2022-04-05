import 'package:mamba/models/commands/join/planning_join_send_command_type.dart';
import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_join_send_command.g.dart';

@JsonSerializable()
class PlanningJoinSendCommand extends PlanningCommand {
  PlanningJoinSendCommandType type;

  PlanningMessage? message;

  PlanningJoinSendCommand({
    required UuidValue? uuid,
    this.message,
    required this.type,
  }) : super(
          uuid: uuid,
        );

  factory PlanningJoinSendCommand.fromJson(Map<String, dynamic> data) =>
      _$PlanningJoinSendCommandFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningJoinSendCommandToJson(this);
}
