import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_participant_group_dto.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/cards/planning_session_participants_card.dart';
import 'package:mamba/widgets/cards/planning_session_ticket_card.dart';
import 'package:mamba/widgets/cards/planning_session_voting_card.dart';
import 'package:mamba/widgets/rows/participant_row.dart';

class PlanningJoinVotingState extends StatelessWidget {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCommandButton> commands;
  final List<PlanningParticipantGroupDto> participants;
  final String ticketTitle;
  final String? ticketDescription;
  final List<PlanningCard> availableCards;
  final PlanningCard? selectedCard;
  final Set<String> selectedTags;
  final String? selectedTag;
  final Function(PlanningCard, String?) onSelectCard;
  final Function(String) onSelectTag;

  const PlanningJoinVotingState({
    Key? key,
    required this.sessionName,
    required this.participants,
    required this.commands,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticketTitle,
    this.ticketDescription,
    required this.selectedTags,
    this.selectedTag,
    required this.availableCards,
    this.selectedCard,
    required this.onSelectCard,
    required this.onSelectTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            PlanningSessionNameCard(
              sessionName: sessionName,
              commands: commands,
              coffeeVoteCount: coffeeVoteCount,
              spectatorCount: spectatorCount,
            ),
            PlanningSessionTicketCard(
              ticketTitle: ticketTitle,
              ticketDescription: ticketDescription,
              commands: const [],
            ),
            PlanningSessionVotingCard(
              planningCards: availableCards,
              selectedCard: selectedCard,
              onSelectCard: onSelectCard,
              onSelectTag: onSelectTag,
              tags: selectedTags,
              selectedTag: selectedTag,
            ),
            PlanningSessionParticipantsCard(
              participants: participants,
              participantCommands: const [],
              voteState: ParticipantRowVoteState.obfuscated,
            ),
          ],
        ),
      ),
    );
  }
}
