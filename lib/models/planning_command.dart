import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_command.g.dart';

@JsonSerializable()
class PlanningCommand {
  @JsonKey(fromJson: idFromString, toJson: stringFromId)
  final UuidValue? uuid;

  PlanningCommand({required this.uuid});

  static String? stringFromId(UuidValue? uuid) {
    return uuid?.uuid;
  }

  static UuidValue? idFromString(String? uuid) {
    if (uuid != null) {
      return UuidValue(uuid);
    }
    return null;
  }

  factory PlanningCommand.fromJson(Map<String, dynamic> data) =>
      _$PlanningCommandFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningCommandToJson(this);
}
