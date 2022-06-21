import 'package:flutter/material.dart';
import 'package:mamba/mixins/voting_results_mixin.dart';
import 'package:mamba/models/planning_card_group.dart';
import "package:collection/collection.dart";
import 'package:mamba/models/planning_voting_result_group.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionVotesGraph extends StatelessWidget
    with VotingResultsMixin {
  final List<PlanningCardGroup> voteGroups;
  late final List<PlanningVotingResultGroup> votingResults;

  PlanningSessionVotesGraph({
    Key? key,
    required this.voteGroups,
  }) : super(key: key) {
    votingResults = makeVotingResults(voteGroups: voteGroups);
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
          children: [
            const TitleText(text: 'Results'),
            const SizedBox(height: 16),
            Column(
              children: votingResults.isEmpty
                  ? [const DescriptionText(text: 'No votes were cast')]
                  : votingResults
                      .mapIndexed(
                        (index, votingResult) => Column(
                          children: [
                            if (votingResult.tag != null && index > 0)
                              const SizedBox(height: 10),
                            if (votingResult.tag != null)
                              DescriptionText(text: votingResult.tag!),
                            if (votingResult.tag != null)
                              const SizedBox(height: 10),
                            if (votingResult.tag == null && index > 0)
                              const SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: votingResult.results
                                      .map(
                                        (votingResult) => Flexible(
                                          flex: votingResult.ratio,
                                          child: Container(
                                            color: darkPurple.withOpacity(
                                                votingResult.transparency),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: Text(
                                                  votingResult.title,
                                                  style: TextStyle(
                                                      color:
                                                          votingResult.color),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
