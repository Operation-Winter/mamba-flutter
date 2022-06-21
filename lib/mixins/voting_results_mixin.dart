import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_voting_result.dart';
import 'package:mamba/models/planning_voting_result_group.dart';

mixin VotingResultsMixin {
  List<PlanningVotingResultGroup> makeVotingResults(
      {required List<PlanningCardGroup> voteGroups}) {
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

      voteResults.sort((a, b) {
        int ratioComp = b.ratio.compareTo(a.ratio);
        if (ratioComp == 0) {
          return int.parse(b.title).compareTo(int.parse(a.title));
        }
        return ratioComp;
      });

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
}
