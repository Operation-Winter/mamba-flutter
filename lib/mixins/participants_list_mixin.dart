import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_participant_dto.dart';
import 'package:mamba/models/planning_ticket_vote.dart';
import 'package:collection/collection.dart';

mixin ParticipantsListMixin {
  List<PlanningParticipantDto> makeParticipantDtos({
    required List<PlanningParticipant> participants,
    List<PlanningTicketVote>? votes,
  }) {
    var ticketGroups = votes != null
        ? groupBy(votes, (PlanningTicketVote vote) => vote.selectedCard)
        : null;

    return participants.map((participant) {
      var participantSpecificVotes = votes?.where(
          (element) => element.participantId == participant.participantId);

      var participantVotes = participantSpecificVotes?.isEmpty == true
          ? null
          : participantSpecificVotes
              ?.map((vote) => vote.selectedCard)
              .whereNotNull()
              .toList();
      bool highligted = false;

      if (ticketGroups != null && participantVotes?.isNotEmpty == true) {
        var votesTotal = ticketGroups[participantVotes!.last]?.length ?? 0;
        var smallestGroupLength = ticketGroups.entries
            .reduce((current, next) =>
                current.value.length < next.value.length ? current : next)
            .value
            .length;
        highligted = votesTotal <= smallestGroupLength;
      }

      return PlanningParticipantDto(
        participantId: participant.participantId,
        name: participant.name,
        connected: participant.connected,
        votes: participantVotes,
        highlighted: highligted,
      );
    }).toList();
  }
}
