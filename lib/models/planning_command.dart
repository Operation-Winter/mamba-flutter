import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_command.g.dart';

@JsonSerializable()
class PlanningCommand {
  @JsonKey(fromJson: _idFromString, toJson: _stringFromId)
  final UuidValue uuid;
  final String type;
  final Object? message;

  PlanningCommand({required this.uuid, required this.type, this.message});

  static String _stringFromId(UuidValue uuid) {
    return uuid.uuid;
  }

  static UuidValue _idFromString(String uuid) {
    return UuidValue(uuid);
  }

  factory PlanningCommand.fromJson(Map<String, dynamic> data) =>
      _$PlanningCommandFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningCommandToJson(this);
}
