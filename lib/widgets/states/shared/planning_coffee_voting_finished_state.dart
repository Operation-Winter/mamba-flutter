import 'package:flutter/material.dart';
import 'package:mamba/widgets/cards/planning_session_coffee_break_voting_finished_card.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';

class PlanningCoffeeVotingFinishedState extends StatelessWidget {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCommandButton> commands;

  const PlanningCoffeeVotingFinishedState({
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
            PlanningSessionCoffeeBreakVotingFinishedCard(),
          ],
        ),
      ),
    );
  }
}
