import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_participant.g.dart';

@JsonSerializable()
class PlanningParticipant {
  @JsonKey(fromJson: _idFromString, toJson: _stringFromId)
  UuidValue participantId;
  String name;
  bool connected;

  PlanningParticipant({
    required this.participantId,
    required this.name,
    required this.connected,
  });

  static String _stringFromId(UuidValue uuid) {
    return uuid.uuid;
  }

  static UuidValue _idFromString(String uuid) {
    return UuidValue(uuid);
  }

  factory PlanningParticipant.fromJson(Map<String, dynamic> data) =>
      _$PlanningParticipantFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningParticipantToJson(this);
}
