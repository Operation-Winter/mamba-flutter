import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/planning_card.dart';

import 'package:json_annotation/json_annotation.dart';
part 'planning_vote_message.g.dart';

@JsonSerializable()
class PlanningVoteMessage implements PlanningMessage {
  final PlanningCard selectedCard;
  final String? tag;

  PlanningVoteMessage({
    required this.selectedCard,
    this.tag,
  });

  factory PlanningVoteMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningVoteMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningVoteMessageToJson(this);
}
