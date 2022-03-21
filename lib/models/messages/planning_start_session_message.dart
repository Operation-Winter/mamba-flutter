import 'package:mamba/models/planning_card.dart';

class PlanningStartSessionMessage {
  String sessionName;
  bool autoCompleteVoting;
  List<PlanningCard> availableCards;

  PlanningStartSessionMessage({
    required this.sessionName,
    required this.autoCompleteVoting,
    required this.availableCards,
  });

  factory PlanningStartSessionMessage.fromJson(dynamic json) {
    return PlanningStartSessionMessage(
      sessionName: json['sessionName'] as String,
      autoCompleteVoting: json['autoCompleteVoting'] as bool,
      availableCards: json['availableCards'] as List<PlanningCard>,
    );
  }
}
