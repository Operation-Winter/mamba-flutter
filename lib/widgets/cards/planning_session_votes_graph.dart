import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_voting_result.dart';
import "package:collection/collection.dart";
import 'package:mamba/models/planning_voting_result_group.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionVotesGraph extends StatelessWidget {
  final List<PlanningCardGroup> voteGroups;

  const PlanningSessionVotesGraph({
    Key? key,
    required this.voteGroups,
  }) : super(key: key);

  List<PlanningVotingResultGroup> get votingResults {
    List<PlanningVotingResultGroup> groups = [];

    for (var group in voteGroups) {
      var votingGroups =
          groupBy(group.planningCards, (PlanningCard vote) => vote.title);

      List<PlanningVotingResult> voteResults =
          votingGroups.entries.map((votingGroup) {
        return PlanningVotingResult(
          title: votingGroup.key,
          transparency: 1,
          color: Colors.white,
          ratio: votingGroup.value.length,
        );
      }).toList();

      voteResults.sort((a, b) => b.ratio.compareTo(a.ratio));

      voteResults.forEachIndexed((index, element) {
        element.transparency =
            ((votingGroups.length - index) / votingGroups.length);
        element.color =
            element.transparency >= 0.5 ? Colors.white : Colors.black;
      });

      groups.add(PlanningVotingResultGroup(
        tag: group.tag,
        results: voteResults,
      ));
    }

    return groups;
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
