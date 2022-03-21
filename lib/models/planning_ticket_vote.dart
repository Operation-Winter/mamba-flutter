import 'package:mamba/models/planning_card.dart';
import 'package:uuid/uuid.dart';
import 'package:enum_to_string/enum_to_string.dart';

class PlanningTicketVote {
  Uuid participantId;
  PlanningCard? planningCard;

  PlanningTicketVote({required this.participantId, this.planningCard});

  factory PlanningTicketVote.fromJson(dynamic json) {
    return PlanningTicketVote(
      participantId: json['participantId'] as Uuid,
      planningCard: json['planningCard'] != null
          ? EnumToString.fromString(PlanningCard.values, json['planningCard'])
          : null,
    );
  }
}
