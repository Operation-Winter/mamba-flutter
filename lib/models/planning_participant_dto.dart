import 'package:mamba/models/planning_card.dart';
import 'package:uuid/uuid.dart';

class PlanningParticipantDto {
  UuidValue participantId;
  String name;
  bool connected;
  List<PlanningCard>? votes;
  bool highlighted;

  PlanningParticipantDto({
    required this.participantId,
    required this.name,
    required this.connected,
    this.votes,
    required this.highlighted,
  });
}
