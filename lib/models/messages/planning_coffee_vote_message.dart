import 'package:mamba/models/messages/planning_message.dart';

import 'package:json_annotation/json_annotation.dart';
part 'planning_coffee_vote_message.g.dart';

@JsonSerializable()
class PlanningCoffeeVoteMessage implements PlanningMessage {
  final bool vote;

  PlanningCoffeeVoteMessage({
    required this.vote,
  });

  factory PlanningCoffeeVoteMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningCoffeeVoteMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningCoffeeVoteMessageToJson(this);
}
