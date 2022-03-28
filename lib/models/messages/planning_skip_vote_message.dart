import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_skip_vote_message.g.dart';

@JsonSerializable()
class PlanningSkipVoteMessage {
  @JsonKey(fromJson: _idFromString, toJson: _stringFromId)
  UuidValue participantId;

  PlanningSkipVoteMessage({required this.participantId});

  static String _stringFromId(UuidValue uuid) {
    return uuid.uuid;
  }

  static UuidValue _idFromString(String uuid) {
    return UuidValue(uuid);
  }

  factory PlanningSkipVoteMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningSkipVoteMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningSkipVoteMessageToJson(this);
}