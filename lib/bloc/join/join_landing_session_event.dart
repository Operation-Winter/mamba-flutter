part of 'join_landing_session_bloc.dart';

@immutable
abstract class JoinLandingSessionEvent {}

// Send commands

class JoinSendJoinSession extends JoinLandingSessionEvent {}

class JoinSendVote extends JoinLandingSessionEvent {
  final PlanningCard selectedCard;
  final String? tag;

  JoinSendVote({
    required this.selectedCard,
    this.tag,
  });
}

class JoinSendLeaveSession extends JoinLandingSessionEvent {}

class JoinSendReconnect extends JoinLandingSessionEvent {}

class JoinSendChangeName extends JoinLandingSessionEvent {
  final String newUsername;

  JoinSendChangeName({required this.newUsername});
}

class JoinSendRequestCoffeeBreak extends JoinLandingSessionEvent {}

// Receive commands
class JoinReceiveNoneState extends JoinLandingSessionEvent {
  final PlanningSessionStateMessage message;

  JoinReceiveNoneState({required this.message});
}

class JoinReceiveVotingState extends JoinLandingSessionEvent {
  final PlanningSessionStateMessage message;

  JoinReceiveVotingState({required this.message});
}

class JoinReceiveVotingFinishedState extends JoinLandingSessionEvent {
  final PlanningSessionStateMessage message;

  JoinReceiveVotingFinishedState({required this.message});
}

class JoinReceiveInvalidCommand extends JoinLandingSessionEvent {
  final PlanningInvalidCommandMessage message;

  JoinReceiveInvalidCommand({required this.message});
}

class JoinReceiveInvalidSession extends JoinLandingSessionEvent {}

class JoinReceiveRemoveParticipant extends JoinLandingSessionEvent {}

class JoinReceiveEndSession extends JoinLandingSessionEvent {}

class JoinLandingError extends JoinLandingSessionEvent {
  final String code;
  final String description;

  JoinLandingError({
    required this.code,
    required this.description,
  });
}

class JoinDidSelectTag extends JoinLandingSessionEvent {
  final String? tag;

  JoinDidSelectTag({
    this.tag,
  });
}
