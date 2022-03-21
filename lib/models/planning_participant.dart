import 'package:uuid/uuid.dart';

class PlanningParticipant {
  Uuid participantId;
  String name;
  bool connected;

  PlanningParticipant({
    required this.participantId,
    required this.name,
    required this.connected,
  });
}
