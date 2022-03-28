import 'package:mamba/models/planning_card.dart';

import 'package:json_annotation/json_annotation.dart';
part 'planning_vote_message.g.dart';

@JsonSerializable()
class PlanningVoteMessage {
  PlanningCard selectedCard;

  PlanningVoteMessage({required this.selectedCard});

  factory PlanningVoteMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningVoteMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningVoteMessageToJson(this);
}
