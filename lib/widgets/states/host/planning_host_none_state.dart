import 'package:flutter/material.dart';
import 'package:mamba/models/planning_participant_dto.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/cards/planning_session_participants_card.dart';
import 'package:mamba/widgets/rows/participant_row.dart';

class PlanningHostNoneState extends StatelessWidget {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCommandButton> commands;
  final List<PlanningParticipantCommand> participantCommands;
  final List<PlanningParticipantDto> participants;

  const PlanningHostNoneState({
    Key? key,
    required this.sessionName,
    required this.participants,
    required this.commands,
    required this.participantCommands,
    required this.coffeeVoteCount,
    required this.spectatorCount,
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
            PlanningSessionParticipantsCard(
              participants: participants,
              participantCommands: participantCommands,
              voteState: ParticipantRowVoteState.hidden,
            ),
          ],
        ),
      ),
    );
  }
}
