part of 'join_landing_session_bloc.dart';

@immutable
abstract class JoinLandingSessionState {}

class JoinLandingSessionLoading extends JoinLandingSessionState {}

class JoinLandingSessionNone extends JoinLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;

  JoinLandingSessionNone({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
  });
}

class JoinLandingSessionVoting extends JoinLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;
  final PlanningTicket ticket;

  JoinLandingSessionVoting({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticket,
  });
}

class JoinLandingSessionVotingFinished extends JoinLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;
  final PlanningTicket ticket;

  JoinLandingSessionVotingFinished({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticket,
  });
}

class JoinLandingSessionCoffeeVoting extends JoinLandingSessionState {}

class JoinLandingSessionCoffeeVotingFinished extends JoinLandingSessionState {}

class JoinLandingSessionError extends JoinLandingSessionState {
  final String sessionName;
  final String errorCode;
  final String errorDescription;

  JoinLandingSessionError({
    required this.sessionName,
    required this.errorCode,
    required this.errorDescription,
  });
}

class JoinLandingRemovedFromSession extends JoinLandingSessionState {
  final String sessionName;

  JoinLandingRemovedFromSession({required this.sessionName});
}

class JoinLandingLeftSession extends JoinLandingSessionState {
  final String sessionName;

  JoinLandingLeftSession({required this.sessionName});
}

class JoinLandingSessionEnded extends JoinLandingSessionState {
  final String sessionName;

  JoinLandingSessionEnded({required this.sessionName});
}
