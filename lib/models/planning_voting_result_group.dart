import 'package:mamba/models/planning_voting_result.dart';

class PlanningVotingResultGroup {
  String? tag;
  List<PlanningVotingResult> results;

  PlanningVotingResultGroup({
    this.tag,
    required this.results,
  });
}
