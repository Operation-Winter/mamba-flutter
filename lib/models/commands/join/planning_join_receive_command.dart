import 'package:mamba/models/commands/join/planning_join_receive_command_type.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_join_receive_command.g.dart';

@JsonSerializable()
class PlanningJoinReceiveCommand extends PlanningCommand {
  PlanningJoinReceiveCommandType type;

  PlanningJoinReceiveCommand({
    required UuidValue? uuid,
    Object? message,
    required this.type,
  }) : super(
          uuid: uuid,
          message: message,
        );

  factory PlanningJoinReceiveCommand.fromJson(Map<String, dynamic> data) =>
      _$PlanningJoinReceiveCommandFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningJoinReceiveCommandToJson(this);
}
