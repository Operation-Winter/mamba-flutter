part of 'host_landing_session_bloc.dart';

@immutable
abstract class HostLandingSessionEvent {}

// Send commands

class HostSendStartSession extends HostLandingSessionEvent {}

class HostSendAddTicket extends HostLandingSessionEvent {}

class HostSendSkipVote extends HostLandingSessionEvent {}

class HostSendRemoveParticipant extends HostLandingSessionEvent {}

class HostSendEndSession extends HostLandingSessionEvent {}

class HostSendFinishVoting extends HostLandingSessionEvent {}

class HostSendRevote extends HostLandingSessionEvent {}

class HostSendReconnect extends HostLandingSessionEvent {}

class HostSendEditTicket extends HostLandingSessionEvent {}

class HostSendAddTimer extends HostLandingSessionEvent {}

class HostSendCancelTimer extends HostLandingSessionEvent {}

class HostSendPreviousTickets extends HostLandingSessionEvent {}

// Receive commands

class HostReceiveNoneState extends HostLandingSessionEvent {}

class HostReceiveVotingState extends HostLandingSessionEvent {}

class HostReceiveVotingFinishedState extends HostLandingSessionEvent {}

class HostReceiveInvalidCommand extends HostLandingSessionEvent {}

class HostReceivePreviousTickets extends HostLandingSessionEvent {}
