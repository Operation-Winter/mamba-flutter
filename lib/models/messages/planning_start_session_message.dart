import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/planning_card.dart';

import 'package:json_annotation/json_annotation.dart';
part 'planning_start_session_message.g.dart';

@JsonSerializable()
class PlanningStartSessionMessage implements PlanningMessage {
  final String sessionName;
  final bool autoCompleteVoting;
  final List<PlanningCard> availableCards;
  final String? password;

  PlanningStartSessionMessage({
    required this.sessionName,
    required this.autoCompleteVoting,
    required this.availableCards,
    this.password,
  });

  factory PlanningStartSessionMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningStartSessionMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningStartSessionMessageToJson(this);
}
