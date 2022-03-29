import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mamba/models/messages/planning_start_session_message.dart';
import 'package:mamba/models/planning_card.dart';
import 'package:mamba/models/planning_command.dart';
import 'package:mamba/models/planning_participant.dart';
import 'package:mamba/models/planning_ticket.dart';
import 'package:mamba/networking/url_center.dart';
import 'package:mamba/networking/web_socket_wrapper.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'host_landing_session_event.dart';
part 'host_landing_session_state.dart';

class HostLandingSessionBloc
    extends Bloc<HostLandingSessionEvent, HostLandingSessionState> {
  late final WebSocketNetworking _webSocket;

  UuidValue uuid = const Uuid().v4obj();
  String? sessionCode;
  String sessionName;
  String? participantName;
  List<PlanningCard> availableCards = [];
  List<PlanningParticipant> planningParticipants = [];
  PlanningCard? selectedCard;
  PlanningTicket? ticket;
  bool automaticallyCompleteVoting;
  String? password;
  Set<String> tags;

  HostLandingSessionBloc({
    required this.sessionName,
    this.password,
    required this.availableCards,
    required this.automaticallyCompleteVoting,
    required this.tags,
  }) : super(HostLandingSessionLoading()) {
    _webSocket = WebSocketNetworking(uri: URLCenter.planningHostPath);
    _webSocket.channel.stream.listen((event) {
      _handleReceiveCommand(event);
    }, onError: (error) {}, onDone: () {});

    on<HostLandingSessionEvent>((event, emit) {
      // Send commands
      if (event is HostSendStartSession) {
        _sendStartSessionCommand();
      } else if (event is HostSendAddTicket) {
      } else if (event is HostSendSkipVote) {
      } else if (event is HostSendRemoveParticipant) {
      } else if (event is HostSendEndSession) {
      } else if (event is HostSendFinishVoting) {
      } else if (event is HostSendRevote) {
      } else if (event is HostSendReconnect) {
      } else if (event is HostSendEditTicket) {
      } else if (event is HostSendAddTimer) {
      } else if (event is HostSendCancelTimer) {
      } else if (event is HostSendPreviousTickets) {
      }

      // Receive commands
      else if (event is HostReceiveNoneState) {
        emit(HostLandingSessionNone());
      } else if (event is HostReceiveVotingState) {
      } else if (event is HostReceiveVotingFinishedState) {
      } else if (event is HostReceiveInvalidCommand) {
      } else if (event is HostReceivePreviousTickets) {}
    });
    add(HostSendStartSession());
  }

  _handleReceiveCommand(event) async {
    print(utf8.decode(event));
    var planningCommand =
        PlanningCommand.fromJson(jsonDecode(utf8.decode(event)));
    add(HostReceiveNoneState());
  }

  void sendCommand(PlanningCommand planningCommand) {
    _webSocket.send(planningCommand: planningCommand);
  }

  void _sendStartSessionCommand() {
    var message = PlanningStartSessionMessage(
        sessionName: sessionName,
        autoCompleteVoting: automaticallyCompleteVoting,
        availableCards: availableCards);
    var planningCommand = PlanningCommand(
      uuid: uuid,
      type: "START_SESSION",
      message: message,
    );
    sendCommand(planningCommand);
  }
}
