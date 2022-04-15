import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_participant_dto.dart';
import 'package:mamba/models/planning_ticket_vote.dart';
import 'package:collection/collection.dart';
import 'package:mamba/models/planning_card.dart';

mixin ParticipantsListMixin {
  List<PlanningParticipantDto> makeParticipantDtos({
    required List<PlanningParticipant> participants,
    List<PlanningTicketVote>? votes,
  }) {
    return participants.map((participant) {
      var participantSpecificVotes = votes?.where(
          (element) => element.participantId == participant.participantId);

      var participantVotes = participantSpecificVotes?.isEmpty == true
          ? null
          : participantSpecificVotes
              ?.map((vote) => vote.selectedCard?.title)
              .whereNotNull()
              .toList();

      return PlanningParticipantDto(
        participantId: participant.participantId,
        name: participant.name,
        connected: participant.connected,
        votes: participantVotes,
      );
    }).toList();
  }
}
