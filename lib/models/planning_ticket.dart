import 'package:mamba/models/planning_ticket_vote.dart';

import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planning_ticket.g.dart';

@JsonSerializable()
class PlanningTicket {
  String title;
  String? description;
  List<PlanningTicketVote> ticketVotes;

  PlanningTicket(
      {required this.title, this.description, this.ticketVotes = const []});

  void removeVotes(UuidValue participantId) {
    ticketVotes
        .removeWhere((element) => element.participantId == participantId);
  }

  void removeAllVotes() {
    ticketVotes = [];
  }

  void add({required PlanningTicketVote planningTicketVote}) {
    ticketVotes.add(planningTicketVote);
  }

  factory PlanningTicket.fromJson(Map<String, dynamic> data) =>
      _$PlanningTicketFromJson(data);

  Map<String, dynamic> toJson() => _$PlanningTicketToJson(this);
}
