import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'planning_coffee_vote.g.dart';

@JsonSerializable()
class PlanningCoffeeVote {
  @JsonKey(fromJson: _idFromString, toJson: _stringFromId)
  final UuidValue uuid;
  final bool vote;

  PlanningCoffeeVote({
    required this.uuid,
    required this.vote,
  });

  static String _stringFromId(UuidValue uuid) {
    return uuid.uuid;
  }

  static UuidValue _idFromString(String uuid) {
    return UuidValue(uuid);
  }

  factory PlanningCoffeeVote.fromJson(Map<String, dynamic> data) =>
      _$PlanningCoffeeVoteFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningCoffeeVoteToJson(this);
}
