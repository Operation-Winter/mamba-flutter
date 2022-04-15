import 'package:mamba/models/planning_card.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_ticket_vote.g.dart';

@JsonSerializable()
class PlanningTicketVote {
  @JsonKey(fromJson: _idFromString, toJson: _stringFromId)
  UuidValue participantId;
  PlanningCard? selectedCard;

  PlanningTicketVote({required this.participantId, this.selectedCard});

  static String _stringFromId(UuidValue uuid) {
    return uuid.uuid;
  }

  static UuidValue _idFromString(String uuid) {
    return UuidValue(uuid);
  }

  factory PlanningTicketVote.fromJson(Map<String, dynamic> data) =>
      _$PlanningTicketVoteFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningTicketVoteToJson(this);
}
