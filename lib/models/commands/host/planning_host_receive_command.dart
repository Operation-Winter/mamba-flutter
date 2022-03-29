import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/commands/host/planning_host_receive_command_type.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:uuid/uuid.dart';
part 'planning_host_receive_command.g.dart';

@JsonSerializable()
class PlanningHostReceiveCommand extends PlanningCommand {
  PlanningHostReceiveCommandType type;

  PlanningHostReceiveCommand({
    required UuidValue? uuid,
    Object? message,
    required this.type,
  }) : super(
          uuid: uuid,
          message: message,
        );

  factory PlanningHostReceiveCommand.fromJson(Map<String, dynamic> data) =>
      _$PlanningHostReceiveCommandFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningHostReceiveCommandToJson(this);
}
