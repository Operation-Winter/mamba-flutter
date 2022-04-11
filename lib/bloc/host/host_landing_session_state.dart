part of 'host_landing_session_bloc.dart';

@immutable
abstract class HostLandingSessionState {}

class HostLandingSessionLoading extends HostLandingSessionState {}

class HostLandingSessionNone extends HostLandingSessionState {
  final String sessionName;
  final List<PlanningParticipant> participants;
  final int coffeeVoteCount;
  final int spectatorCount;

  HostLandingSessionNone({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
  });
}

class HostLandingSessionVoting extends HostLandingSessionState {
  final String sessionName;
  final List<PlanningParticipant> participants;
  final int coffeeVoteCount;
  final int spectatorCount;

  HostLandingSessionVoting({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
  });
}

class HostLandingSessionVotingFinished extends HostLandingSessionState {}

class HostLandingSessionCoffeeVoting extends HostLandingSessionState {}

class HostLandingSessionCoffeeVotingFinished extends HostLandingSessionState {}

class HostLandingSessionError extends HostLandingSessionState {}

class HostLandingSessionInvalidCommand extends HostLandingSessionState {}

class HostLandingSessionPreviousTickets extends HostLandingSessionState {}

class HostLandingSessionEnded extends HostLandingSessionState {
  final String sessionName;

  HostLandingSessionEnded({required this.sessionName});
}
