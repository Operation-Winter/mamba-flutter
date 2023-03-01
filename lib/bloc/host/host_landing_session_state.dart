part of 'host_landing_session_bloc.dart';

@immutable
abstract class HostLandingSessionState {}

class HostLandingSessionLoading extends HostLandingSessionState {}

class HostLandingSessionNone extends HostLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantGroupDto> participants;
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
  final List<PlanningParticipantGroupDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;
  final PlanningTicket ticket;

  HostLandingSessionVoting({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticket,
  });
}

class HostLandingSessionVotingFinished extends HostLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantGroupDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;
  final PlanningTicket ticket;
  final List<PlanningCardGroup> voteGroups;

  HostLandingSessionVotingFinished({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticket,
    required this.voteGroups,
  });
}

class HostLandingSessionCoffeeVoting extends HostLandingSessionState {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;

  HostLandingSessionCoffeeVoting({
    required this.sessionName,
    required this.coffeeVoteCount,
    required this.spectatorCount,
  });
}

class HostLandingSessionCoffeeVotingFinished extends HostLandingSessionState {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;

  HostLandingSessionCoffeeVotingFinished({
    required this.sessionName,
    required this.coffeeVoteCount,
    required this.spectatorCount,
  });
}

class HostLandingSessionError extends HostLandingSessionState {
  final String sessionName;
  final String errorCode;
  final String errorDescription;

  HostLandingSessionError({
    required this.sessionName,
    required this.errorCode,
    required this.errorDescription,
  });
}

class HostLandingSessionPreviousTickets extends HostLandingSessionState {}

class HostLandingSessionEnded extends HostLandingSessionState {
  final String sessionName;

  HostLandingSessionEnded({required this.sessionName});
}
