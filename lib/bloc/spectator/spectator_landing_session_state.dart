part of 'spectator_landing_session_bloc.dart';

@immutable
abstract class SpectatorLandingSessionState {}

class SpectatorLandingSessionLoading extends SpectatorLandingSessionState {}

class SpectatorLandingSessionNone extends SpectatorLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantGroupDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;

  SpectatorLandingSessionNone({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
  });
}

class SpectatorLandingSessionVoting extends SpectatorLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantGroupDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;
  final PlanningTicket ticket;
  final List<PlanningCard> availableCards;
  final int? timeLeft;

  SpectatorLandingSessionVoting({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticket,
    required this.availableCards,
    this.timeLeft,
  });
}

class SpectatorLandingSessionVotingFinished
    extends SpectatorLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantGroupDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;
  final PlanningTicket ticket;
  final List<PlanningCardGroup> voteGroups;

  SpectatorLandingSessionVotingFinished({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticket,
    required this.voteGroups,
  });
}

class SpectatorLandingSessionCoffeeVoting extends SpectatorLandingSessionState {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCoffeeVote> coffeeVotes;

  SpectatorLandingSessionCoffeeVoting({
    required this.sessionName,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.coffeeVotes,
  });
}

class SpectatorLandingSessionCoffeeVotingFinished
    extends SpectatorLandingSessionState {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCoffeeVote> coffeeVotes;

  SpectatorLandingSessionCoffeeVotingFinished({
    required this.sessionName,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.coffeeVotes,
  });
}

class SpectatorLandingSessionError extends SpectatorLandingSessionState {
  final String sessionName;
  final String errorCode;
  final String errorDescription;

  SpectatorLandingSessionError({
    required this.sessionName,
    required this.errorCode,
    required this.errorDescription,
  });
}

class SpectatorLandingLeftSession extends SpectatorLandingSessionState {
  final String sessionName;

  SpectatorLandingLeftSession({required this.sessionName});
}

class SpectatorLandingSessionEnded extends SpectatorLandingSessionState {
  final String sessionName;

  SpectatorLandingSessionEnded({required this.sessionName});
}
