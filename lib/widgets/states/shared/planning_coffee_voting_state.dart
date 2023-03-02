import 'package:flutter/material.dart';
import 'package:mamba/widgets/cards/planning_session_coffee_break_voting_card.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';

class PlanningCoffeeVotingState extends StatelessWidget {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCommandButton> commands;
  final bool? vote;
  final Function(bool)? onVoteTap;

  const PlanningCoffeeVotingState({
    Key? key,
    required this.sessionName,
    required this.commands,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    this.vote,
    this.onVoteTap,
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
            PlanningSessionCoffeeBreakVotingCard(
              vote: vote,
              onVoteTap: onVoteTap,
            ),
          ],
        ),
      ),
    );
  }
}
