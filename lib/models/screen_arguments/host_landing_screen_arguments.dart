import 'package:mamba/models/planning_card.dart';

class HostLandingScreenArguments {
  final String sessionName;
  final String? password;
  final List<PlanningCard> availableCards;
  final bool automaticallyCompleteVoting;
  final bool reconnect;

  HostLandingScreenArguments({
    this.sessionName = 'Mamba sizing session',
    this.password,
    this.availableCards = const [],
    this.automaticallyCompleteVoting = false,
    this.reconnect = false,
  });
}
