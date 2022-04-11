import 'package:uuid/uuid.dart';

class PlanningParticipantDto {
  UuidValue participantId;
  String name;
  bool connected;
  List<String>? votes;

  PlanningParticipantDto({
    required this.participantId,
    required this.name,
    required this.connected,
    this.votes,
  });
}
