import 'dart:convert';

import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/networking/web_socket_wrapper.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class PlanningSession extends ChangeNotifier {
  WebSocketNetworking webSocket;

  UuidValue uuid = const Uuid().v4obj();
  String? sessionCode;
  String? sessionName;
  String? participantName;
  List<PlanningCard> availableCards = [];
  List<PlanningParticipant> planningParticipants = [];
  PlanningCard? selectedCard;
  PlanningTicket? ticket;
  bool automaticallyCompleteVoting;

  PlanningSession(
    this.webSocket, {
    this.sessionCode,
    this.sessionName,
    this.participantName,
    this.availableCards = const [],
    this.planningParticipants = const [],
    this.selectedCard,
    this.ticket,
    this.automaticallyCompleteVoting = true,
  }) {
    _listenToSession();
  }

  void sendCommand(PlanningCommand planningCommand) {
    webSocket.send(planningCommand: planningCommand);
  }

  void _listenToSession() async {
    await for (final value in webSocket.channel.stream) {
      var planningCommand =
          PlanningCommand.fromJson(jsonDecode(utf8.decode(value)));
      parseCommand(planningCommand);
    }
  }

  void parseCommand(PlanningCommand planningCommand) {
    throw Exception('This function needs to be overriden by sub-classes');
  }
}
