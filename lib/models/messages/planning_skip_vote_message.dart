import 'package:uuid/uuid.dart';

class PlanningSkipVoteMessage {
  Uuid participantId;

  PlanningSkipVoteMessage({required this.participantId});

  factory PlanningSkipVoteMessage.fromJson(dynamic json) {
    return PlanningSkipVoteMessage(
      participantId: json['participantId'] as Uuid,
    );
  }
}
