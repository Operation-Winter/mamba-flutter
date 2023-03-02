import 'package:flutter/material.dart';
import 'package:mamba/models/planning_coffee_vote.dart';
import 'package:mamba/widgets/cards/planning_session_coffee_break_voting_card.dart';
import 'package:mamba/widgets/cards/planning_session_coffee_break_voting_results_card.dart';
import 'package:mamba/widgets/cards/planning_session_name_card.dart';

class PlanningCoffeeVotingState extends StatelessWidget {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCommandButton> commands;
  final List<PlanningCoffeeVote> coffeeVotes;
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
    required this.coffeeVotes,
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
            PlanningSessionCoffeeBreakVotingResultsCard(
              coffeeVotes: coffeeVotes,
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
