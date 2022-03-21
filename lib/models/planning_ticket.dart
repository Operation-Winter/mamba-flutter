import 'package:mamba/models/planning_ticket_vote.dart';

import 'package:uuid/uuid.dart';

class PlanningTicket {
  String title;
  String? description;
  List<PlanningTicketVote> ticketVotes;

  PlanningTicket(
      {required this.title, this.description, this.ticketVotes = const []});

  void removeVotes(Uuid participantId) {
    ticketVotes
        .removeWhere((element) => element.participantId == participantId);
  }

  void removeAllVotes() {
    ticketVotes = [];
  }

  void add({required PlanningTicketVote planningTicketVote}) {
    ticketVotes.add(planningTicketVote);
  }
}
