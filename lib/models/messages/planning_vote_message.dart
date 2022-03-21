import 'package:mamba/models/planning_card.dart';

class PlanningVoteMessage {
  PlanningCard selectedCard;

  PlanningVoteMessage({required this.selectedCard});

  factory PlanningVoteMessage.fromJson(dynamic json) {
    return PlanningVoteMessage(
        selectedCard: json['selectedCard'] as PlanningCard);
  }
}
