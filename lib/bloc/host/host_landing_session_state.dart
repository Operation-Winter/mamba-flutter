part of 'host_landing_session_bloc.dart';

@immutable
abstract class HostLandingSessionState {}

class HostLandingSessionLoading extends HostLandingSessionState {}

class HostLandingSessionNone extends HostLandingSessionState {
  final String sessionName;

  HostLandingSessionNone({required this.sessionName});
}

class HostLandingSessionVoting extends HostLandingSessionState {}

class HostLandingSessionVotingFinished extends HostLandingSessionState {}

class HostLandingSessionCoffeeVoting extends HostLandingSessionState {}

class HostLandingSessionCoffeeVotingFinished extends HostLandingSessionState {}

class HostLandingSessionError extends HostLandingSessionState {}

class HostLandingSessionInvalidCommand extends HostLandingSessionState {}

class HostLandingSessionPreviousTickets extends HostLandingSessionState {}
