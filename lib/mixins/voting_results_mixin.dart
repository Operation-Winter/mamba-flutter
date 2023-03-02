import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_card_group.dart';
import 'package:mamba/models/planning_coffee_vote.dart';
import 'package:mamba/models/planning_voting_result_group.dart';
import 'package:mamba/widgets/graphs/horizontal_stacked_bar_graph.dart';

mixin VotingResultsMixin {
  _sortResults({
    required List<HorizontalStackedBarGraphData> graphData,
    required bool parseAsIntWhenEqual,
  }) {
    graphData.sort((a, b) {
      int ratioComp = b.ratio.compareTo(a.ratio);
      if (parseAsIntWhenEqual && ratioComp == 0) {
        return int.parse(b.title).compareTo(int.parse(a.title));
      }
      return ratioComp;
    });
  }

  _updateTransparencyAndColor({
    required List<HorizontalStackedBarGraphData> graphData,
    required int totalItemCount,
  }) {
    graphData.forEachIndexed((index, data) {
      data.transparency = ((totalItemCount - index) / totalItemCount);
      data.color = data.transparency >= 0.5 ? Colors.white : Colors.black;
    });
  }

  List<PlanningVotingResultGroup> makeVotingResults(
      {required List<PlanningCardGroup> voteGroups}) {
    List<PlanningVotingResultGroup> groups = [];

    for (var group in voteGroups) {
      var votingGroups =
          groupBy(group.planningCards, (PlanningCard vote) => vote.title);

      List<HorizontalStackedBarGraphData> graphData =
          votingGroups.entries.map((votingGroup) {
        return HorizontalStackedBarGraphData(
          title: votingGroup.key,
          transparency: 1,
          color: Colors.white,
          ratio: votingGroup.value.length,
        );
      }).toList();

      _sortResults(
        graphData: graphData,
        parseAsIntWhenEqual: true,
      );

      _updateTransparencyAndColor(
        graphData: graphData,
        totalItemCount: votingGroups.length,
      );

      groups.add(PlanningVotingResultGroup(
        tag: group.tag,
        graphData: graphData,
      ));
    }

    return groups;
  }

  List<HorizontalStackedBarGraphData> makeCoffeeBreakVotingResults({
    required List<PlanningCoffeeVote> coffeeVotes,
  }) {
    var yesCount = coffeeVotes.where((element) => element.vote == true).length;
    var noCount = coffeeVotes.where((element) => element.vote == false).length;

    List<HorizontalStackedBarGraphData> graphData = [];

    if (yesCount > 0) {
      graphData.add(
        HorizontalStackedBarGraphData(
          title: "Yes - $yesCount",
          color: Colors.white,
          transparency: 1,
          ratio: yesCount,
        ),
      );
    }

    if (noCount > 0) {
      graphData.add(
        HorizontalStackedBarGraphData(
          title: "No - $noCount",
          color: Colors.white,
          transparency: 1,
          ratio: noCount,
        ),
      );
    }

    _sortResults(
      graphData: graphData,
      parseAsIntWhenEqual: false,
    );
    _updateTransparencyAndColor(
      graphData: graphData,
      totalItemCount: coffeeVotes.length,
    );

    return graphData;
  }
}
