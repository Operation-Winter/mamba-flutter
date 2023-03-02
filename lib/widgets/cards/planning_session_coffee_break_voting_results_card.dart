import 'package:flutter/material.dart';
import 'package:mamba/mixins/voting_results_mixin.dart';
import 'package:mamba/models/planning_coffee_vote.dart';
import 'package:mamba/widgets/graphs/horizontal_stacked_bar_graph.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionCoffeeBreakVotingResultsCard extends StatelessWidget
    with VotingResultsMixin {
  final List<PlanningCoffeeVote> coffeeVotes;
  late final List<HorizontalStackedBarGraphData> graphData;

  PlanningSessionCoffeeBreakVotingResultsCard({
    super.key,
    required this.coffeeVotes,
  }) {
    graphData = makeCoffeeBreakVotingResults(coffeeVotes: coffeeVotes);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleText(text: "Coffee break voting results"),
            const SizedBox(height: 10),
            graphData.isEmpty
                ? const DescriptionText(text: 'No votes have been cast')
                : HorizontalStackedBarGraph(
                    barGraphData: graphData,
                  ),
          ],
        ),
      ),
    );
  }
}
