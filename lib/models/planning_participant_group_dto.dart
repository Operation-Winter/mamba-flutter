import 'package:mamba/models/planning_participant_dto.dart';

class PlanningParticipantGroupDto {
  String? tag;
  List<PlanningParticipantDto> participants;

  PlanningParticipantGroupDto({
    this.tag,
    required this.participants,
  });
}
