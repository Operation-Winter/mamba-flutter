import 'package:flutter/material.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';
import 'package:mamba/widgets/cards/planning_session_participants_card.dart';

class PlanningHostNoneState extends StatelessWidget {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCommandButton> commands;

  const PlanningHostNoneState({
    Key? key,
    required this.sessionName,
    required this.commands,
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
            const PlanningSessionParticipantsCard(),
          ],
        ),
      ),
    );
  }
}
