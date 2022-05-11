import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_participant_dto.dart';
import 'package:mamba/models/planning_participant_group_dto.dart';
import 'package:mamba/models/planning_ticket_vote.dart';
import 'package:collection/collection.dart';

mixin ParticipantsListMixin {
  List<PlanningParticipantGroupDto> makeParticipantGroupDtos({
    required List<PlanningParticipant> participants,
    List<PlanningTicketVote>? votes,
  }) {
    var tagGroups = votes != null
        ? groupBy(votes, (PlanningTicketVote vote) => vote.tag)
        : null;
    List<PlanningParticipantGroupDto> planningParticipantGroupDto = [];
    tagGroups?.forEach(
      (tag, tagVotes) {
        var participantDtos = _makeParticipantDtos(
          participants: participants,
          votes: tagVotes,
        );
        if (participantDtos.isNotEmpty) {
          planningParticipantGroupDto.add(
            PlanningParticipantGroupDto(
              tag: tag,
              participants: participantDtos,
            ),
          );
        }
      },
    );

    var skippedParticipants = _makeSkippedParticipantDtos(
      participants: participants,
      votes: votes,
    );
    if (skippedParticipants.isNotEmpty) {
      planningParticipantGroupDto.add(PlanningParticipantGroupDto(
        tag: null,
        participants: skippedParticipants,
      ));
    }

    return planningParticipantGroupDto;
  }

  List<PlanningParticipantDto> _makeParticipantDtos({
    required List<PlanningParticipant> participants,
    List<PlanningTicketVote>? votes,
  }) {
    var ticketGroups = votes != null
        ? groupBy(votes, (PlanningTicketVote vote) => vote.selectedCard)
        : null;
    ticketGroups?.remove(null);

    return participants
        .map((participant) {
          var participantSpecificVotes = votes?.where(
              (element) => element.participantId == participant.participantId);

          var participantVotes = participantSpecificVotes?.isEmpty == true
              ? null
              : participantSpecificVotes
                  ?.map((vote) => vote.selectedCard)
                  .whereNotNull()
                  .toList();
          bool highligted = false;

          if (participantVotes == null || participantVotes.isEmpty == true) {
            return null;
          }

          if (ticketGroups != null && participantVotes.isNotEmpty == true) {
            var votesTotal = ticketGroups[participantVotes.last]?.length ?? 0;
            var smallestGroupLength = ticketGroups.entries
                .reduce((current, next) =>
                    current.value.length < next.value.length ? current : next)
                .value
                .length;
            highligted =
                votesTotal <= smallestGroupLength && ticketGroups.length > 1;
          }

          return PlanningParticipantDto(
            participantId: participant.participantId,
            name: participant.name,
            connected: participant.connected,
            votes: participantVotes,
            highlighted: highligted,
          );
        })
        .whereNotNull()
        .toList();
  }

  List<PlanningParticipantDto> _makeSkippedParticipantDtos({
    required List<PlanningParticipant> participants,
    List<PlanningTicketVote>? votes,
  }) {
    return participants
        .map((participant) {
          var participantSpecificVotes = votes?.where(
              (element) => element.participantId == participant.participantId);

          var participantVotes = participantSpecificVotes?.isEmpty == true
              ? null
              : participantSpecificVotes
                  ?.map((vote) => vote.selectedCard)
                  .whereNotNull()
                  .toList();

          if (participantVotes != null && participantVotes.isNotEmpty == true) {
            return null;
          }

          return PlanningParticipantDto(
            participantId: participant.participantId,
            name: participant.name,
            connected: participant.connected,
            votes: participantVotes,
            highlighted: false,
          );
        })
        .whereNotNull()
        .toList();
  }

  List<PlanningCardGroup> makeGroupedCards({List<PlanningTicketVote>? votes}) {
    var tagGroups = votes != null
        ? groupBy(votes, (PlanningTicketVote vote) => vote.tag)
        : null;

    List<PlanningCardGroup> planningCardGroups = [];

    tagGroups?.forEach((tag, ticketVotes) {
      var planningCards =
          ticketVotes.map((vote) => vote.selectedCard).whereNotNull().toList();

      if (planningCards.isNotEmpty) {
        planningCardGroups.add(PlanningCardGroup(
          tag: tag,
          planningCards: planningCards,
        ));
      }
    });

    return planningCardGroups;
  }
}
