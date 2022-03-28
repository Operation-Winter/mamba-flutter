import 'package:mamba/models/planning_card.dart';

import 'package:json_annotation/json_annotation.dart';
part 'planning_start_session_message.g.dart';

@JsonSerializable()
class PlanningStartSessionMessage {
  String sessionName;
  bool autoCompleteVoting;
  List<PlanningCard> availableCards;

  PlanningStartSessionMessage({
    required this.sessionName,
    required this.autoCompleteVoting,
    required this.availableCards,
  });

  factory PlanningStartSessionMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningStartSessionMessageFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningStartSessionMessageToJson(this);
}
