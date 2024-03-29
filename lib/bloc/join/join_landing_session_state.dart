part of 'join_landing_session_bloc.dart';

@immutable
abstract class JoinLandingSessionState {}

class JoinLandingSessionLoading extends JoinLandingSessionState {}

class JoinLandingSessionNone extends JoinLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantGroupDto> participants;
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
  final List<PlanningParticipantGroupDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;
  final PlanningTicket ticket;
  final List<PlanningCard> availableCards;
  final PlanningCard? selectedCard;
  final String? selectedTag;
  final int? timeLeft;

  JoinLandingSessionVoting({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticket,
    required this.availableCards,
    this.selectedCard,
    this.selectedTag,
    this.timeLeft,
  });
}

class JoinLandingSessionVotingFinished extends JoinLandingSessionState {
  final String sessionName;
  final List<PlanningParticipantGroupDto> participants;
  final int coffeeVoteCount;
  final int spectatorCount;
  final PlanningTicket ticket;
  final List<PlanningCardGroup> voteGroups;

  JoinLandingSessionVotingFinished({
    required this.sessionName,
    required this.participants,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.ticket,
    required this.voteGroups,
  });
}

class JoinLandingSessionCoffeeVoting extends JoinLandingSessionState {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final bool? vote;
  final List<PlanningCoffeeVote> coffeeVotes;

  JoinLandingSessionCoffeeVoting({
    required this.sessionName,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    this.vote,
    required this.coffeeVotes,
  });
}

class JoinLandingSessionCoffeeVotingFinished extends JoinLandingSessionState {
  final String sessionName;
  final int coffeeVoteCount;
  final int spectatorCount;
  final List<PlanningCoffeeVote> coffeeVotes;

  JoinLandingSessionCoffeeVotingFinished({
    required this.sessionName,
    required this.coffeeVoteCount,
    required this.spectatorCount,
    required this.coffeeVotes,
  });
}

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
