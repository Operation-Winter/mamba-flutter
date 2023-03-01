part of 'spectator_landing_session_bloc.dart';

@immutable
abstract class SpectatorLandingSessionEvent {}

class SpectatorSendJoinSession extends SpectatorLandingSessionEvent {}

class SpectatorSendLeaveSession extends SpectatorLandingSessionEvent {}

class SpectatorSendReconnect extends SpectatorLandingSessionEvent {}

// Receive commands
class SpectatorReceiveNoneState extends SpectatorLandingSessionEvent {
  final PlanningSessionStateMessage message;

  SpectatorReceiveNoneState({required this.message});
}

class SpectatorReceiveVotingState extends SpectatorLandingSessionEvent {
  final PlanningSessionStateMessage message;

  SpectatorReceiveVotingState({required this.message});
}

class SpectatorReceiveVotingFinishedState extends SpectatorLandingSessionEvent {
  final PlanningSessionStateMessage message;

  SpectatorReceiveVotingFinishedState({required this.message});
}

class SpectatorReceiveInvalidCommand extends SpectatorLandingSessionEvent {
  final PlanningInvalidCommandMessage message;

  SpectatorReceiveInvalidCommand({required this.message});
}

class SpectatorReceiveInvalidSession extends SpectatorLandingSessionEvent {}

class SpectatorReceiveEndSession extends SpectatorLandingSessionEvent {}

class SpectatorLandingError extends SpectatorLandingSessionEvent {
  final String code;
  final String description;

  SpectatorLandingError({
    required this.code,
    required this.description,
  });
}

class SpectatorReceiveCoffeeVotingState extends SpectatorLandingSessionEvent {
  final PlanningSessionStateMessage message;

  SpectatorReceiveCoffeeVotingState({required this.message});
}

class SpectatorReceiveCoffeeVotingFinishedState
    extends SpectatorLandingSessionEvent {
  final PlanningSessionStateMessage message;

  SpectatorReceiveCoffeeVotingFinishedState({required this.message});
}
