import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_participant_dto.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/cards/planning_session_participants_card.dart';
import 'package:mamba/widgets/cards/planning_session_ticket_card.dart';
import 'package:mamba/widgets/cards/planning_session_votes_graph.dart';
import 'package:mamba/widgets/rows/participant_row.dart';

class PlanningVotingFinishedState extends StatelessWidget {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCommandButton> commands;
  final List<PlanningParticipantCommand> participantCommands;
  final List<PlanningCommandButton> ticketCommands;
  final List<PlanningParticipantDto> participants;
  final String ticketTitle;
  final String? ticketDescription;
  final List<PlanningCard> votes;

  const PlanningVotingFinishedState({
    Key? key,
    required this.sessionName,
    required this.participants,
    required this.commands,
    required this.participantCommands,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticketTitle,
    this.ticketDescription,
    required this.ticketCommands,
    required this.votes,
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
              commands: ticketCommands,
            ),
            PlanningSessionVotesGraph(votes: votes),
            PlanningSessionParticipantsCard(
              participants: participants,
              participantCommands: participantCommands,
              voteState: ParticipantRowVoteState.visible,
            ),
          ],
        ),
      ),
    );
  }
}