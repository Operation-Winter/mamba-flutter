import 'package:mamba/models/planning_card.dart';

class PlanningCardGroup {
  String? tag;
  List<PlanningCard> planningCards;

  PlanningCardGroup({
    this.tag,
    required this.planningCards,
  });
}
