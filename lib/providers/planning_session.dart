import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_session_state.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class PlanningSession extends ChangeNotifier {
  Uuid uuid = const Uuid();
  String? sessionCode;
  String? sessionName;
  String? participantName;
  List<PlanningCard> availableCards = [];
  List<PlanningParticipant> planningParticipants = [];
  PlanningCard? selectedCard;
  PlanningSessionState state = PlanningSessionState.loading;
  PlanningTicket? ticket;

  PlanningSession({
    this.sessionCode,
    this.sessionName,
    this.participantName,
    this.availableCards = const [],
    this.planningParticipants = const [],
    this.selectedCard,
    this.ticket,
  });
}
