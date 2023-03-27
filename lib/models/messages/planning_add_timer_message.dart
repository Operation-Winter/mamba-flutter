import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/messages/planning_message.dart';
part 'planning_add_timer_message.g.dart';

@JsonSerializable()
class PlanningAddTimerMessage implements PlanningMessage {
  final int time;

  PlanningAddTimerMessage({required this.time});

  factory PlanningAddTimerMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningAddTimerMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningAddTimerMessageToJson(this);
}
