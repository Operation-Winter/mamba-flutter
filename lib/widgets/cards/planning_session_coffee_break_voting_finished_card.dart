import 'package:flutter/material.dart';
import 'package:mamba/models/planning_coffee_vote.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionCoffeeBreakVotingFinishedCard extends StatelessWidget {
  final List<PlanningCoffeeVote> coffeeVotes;

  const PlanningSessionCoffeeBreakVotingFinishedCard({
    super.key,
    required this.coffeeVotes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            TitleText(text: "Coffee break voting results"),
            SizedBox(height: 10),
            Placeholder(child: Text("Coffee voting finished")),
          ],
        ),
      ),
    );
  }
}
