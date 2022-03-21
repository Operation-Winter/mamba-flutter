import 'package:uuid/uuid.dart';

class PlanningRemoveParticipantMessage {
  Uuid participantId;

  PlanningRemoveParticipantMessage({required this.participantId});

  factory PlanningRemoveParticipantMessage.fromJson(dynamic json) {
    return PlanningRemoveParticipantMessage(
      participantId: json['participantId'] as Uuid,
    );
  }
}
