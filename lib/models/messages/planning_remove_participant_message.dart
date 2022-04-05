import 'package:mamba/models/messages/planning_message.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_remove_participant_message.g.dart';

@JsonSerializable()
class PlanningRemoveParticipantMessage implements PlanningMessage {
  @JsonKey(fromJson: _idFromString, toJson: _stringFromId)
  final UuidValue participantId;

  PlanningRemoveParticipantMessage({required this.participantId});

  static String _stringFromId(UuidValue uuid) {
    return uuid.uuid;
  }

  static UuidValue _idFromString(String uuid) {
    return UuidValue(uuid);
  }

  factory PlanningRemoveParticipantMessage.fromJson(
          Map<String, dynamic> data) =>
      _$PlanningRemoveParticipantMessageFromJson(data);

  Map<String, dynamic> toJson() =>
      _$PlanningRemoveParticipantMessageToJson(this);
}
