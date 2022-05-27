import 'package:mamba/models/messages/planning_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_coffee_vote.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_session_state_message.g.dart';

@JsonSerializable()
class PlanningSessionStateMessage implements PlanningMessage {
  final String sessionCode;
  final String sessionName;
  final String? password;
  final List<PlanningCard> availableCards;
  final List<PlanningParticipant> participants;
  final PlanningTicket? ticket;
  final int? timeLeft;
  final int spectatorCount;
  final int coffeeRequestCount;
  final List<PlanningCoffeeVote>? coffeeVotes;

  PlanningSessionStateMessage({
    required this.sessionCode,
    required this.sessionName,
    this.password,
    required this.availableCards,
    required this.participants,
    this.ticket,
    this.timeLeft,
    required this.spectatorCount,
    required this.coffeeRequestCount,
    required this.coffeeVotes,
  });

  factory PlanningSessionStateMessage.fromJson(Map<String, dynamic> data) =>
      _$PlanningSessionStateMessageFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PlanningSessionStateMessageToJson(this);
}
