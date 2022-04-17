import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_voting_result.dart';
import "package:collection/collection.dart";
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/text/title_text.dart';

class PlanningSessionVotesGraph extends StatelessWidget {
  final List<PlanningCard> votes;

  const PlanningSessionVotesGraph({
    Key? key,
    required this.votes,
  }) : super(key: key);

  List<PlanningVotingResult> get votingResults {
    var votingGroups = groupBy(votes, (PlanningCard vote) => vote.title);

    List<PlanningVotingResult> voteResults =
        votingGroups.entries.map((votingGroup) {
      return PlanningVotingResult(
        title: votingGroup.key,
        transparency: 255,
        color: Colors.white,
        ratio: votingGroup.value.length,
      );
    }).toList();

    voteResults.sort((a, b) => b.ratio.compareTo(a.ratio));

    voteResults.forEachIndexed((index, element) {
      element.transparency =
          (((votingGroups.length - index) / votingGroups.length) * 255).round();
      element.color =
          element.transparency > 127.5 ? Colors.white : Colors.black;
    });

    return voteResults;
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Row(
                children: votingResults
                    .map(
                      (votingResult) => Flexible(
                        flex: votingResult.ratio,
                        child: Container(
                          color:
                              darkPurple.withAlpha(votingResult.transparency),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                votingResult.title,
                                style: TextStyle(color: votingResult.color),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
