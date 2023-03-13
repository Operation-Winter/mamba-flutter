part of 'host_landing_session_bloc.dart';

@immutable
abstract class HostLandingSessionEvent {}

// Send commands

class HostSendStartSession extends HostLandingSessionEvent {}

class HostSendAddTicket extends HostLandingSessionEvent {
  final String title;
  final String? description;
  final Set<String> tags;
  final Set<String> selectedTags;

  HostSendAddTicket({
    required this.title,
    this.description,
    required this.tags,
    required this.selectedTags,
  });
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
  final Set<String> tags;
  final Set<String> selectedTags;

  HostSendEditTicket({
    required this.title,
    this.description,
    required this.tags,
    required this.selectedTags,
  });
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

class HostReceiveInvalidCommand extends HostLandingSessionEvent {
  final PlanningInvalidCommandMessage message;

  HostReceiveInvalidCommand({required this.message});
}

class HostReceivePreviousTickets extends HostLandingSessionEvent {
  final PlanningPreviousTicketsMessage message;

  HostReceivePreviousTickets({required this.message});
}

class HostLandingError extends HostLandingSessionEvent {
  final String code;
  final String description;

  HostLandingError({
    required this.code,
    required this.description,
  });
}

class HostSendRequestCoffeeBreak extends HostLandingSessionEvent {}

class HostSendCoffeeVote extends HostLandingSessionEvent {
  final bool vote;

  HostSendCoffeeVote({
    required this.vote,
  });
}

class HostSendStartCoffeeVote extends HostLandingSessionEvent {}

class HostSendFinishCoffeeVote extends HostLandingSessionEvent {}

class HostSendEndCoffeeVote extends HostLandingSessionEvent {}

class HostReceiveCoffeeVotingState extends HostLandingSessionEvent {
  final PlanningSessionStateMessage message;

  HostReceiveCoffeeVotingState({required this.message});
}

class HostReceiveCoffeeVotingFinishedState extends HostLandingSessionEvent {
  final PlanningSessionStateMessage message;

  HostReceiveCoffeeVotingFinishedState({required this.message});
}
