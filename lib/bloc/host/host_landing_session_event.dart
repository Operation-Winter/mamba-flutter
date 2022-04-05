part of 'host_landing_session_bloc.dart';

@immutable
abstract class HostLandingSessionEvent {}

// Send commands

class HostSendStartSession extends HostLandingSessionEvent {}

class HostSendAddTicket extends HostLandingSessionEvent {
  final String title;
  final String? description;

  HostSendAddTicket({required this.title, this.description});
}

class HostSendSkipVote extends HostLandingSessionEvent {
  final UuidValue participantId;

  HostSendSkipVote({required this.participantId});
}

class HostSendRemoveParticipant extends HostLandingSessionEvent {
  final UuidValue participantId;

  HostSendRemoveParticipant({required this.participantId});
}

class HostSendEndSession extends HostLandingSessionEvent {}

class HostSendFinishVoting extends HostLandingSessionEvent {}

class HostSendRevote extends HostLandingSessionEvent {}

class HostSendReconnect extends HostLandingSessionEvent {}

class HostSendEditTicket extends HostLandingSessionEvent {
  final String title;
  final String? description;

  HostSendEditTicket({required this.title, this.description});
}

class HostSendAddTimer extends HostLandingSessionEvent {
  final int timeInterval;

  HostSendAddTimer({required this.timeInterval});
}

class HostSendCancelTimer extends HostLandingSessionEvent {}

class HostSendPreviousTickets extends HostLandingSessionEvent {}

// Receive commands
class HostReceiveNoneState extends HostLandingSessionEvent {
  final PlanningSessionStateMessage message;

  HostReceiveNoneState({required this.message});
}

class HostReceiveVotingState extends HostLandingSessionEvent {
  final PlanningSessionStateMessage message;

  HostReceiveVotingState({required this.message});
}

class HostReceiveVotingFinishedState extends HostLandingSessionEvent {
  final PlanningSessionStateMessage message;

  HostReceiveVotingFinishedState({required this.message});
}

class HostReceiveInvalidCommand extends HostLandingSessionEvent {}

class HostReceivePreviousTickets extends HostLandingSessionEvent {}
