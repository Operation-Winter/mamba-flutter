import 'package:json_annotation/json_annotation.dart';
import 'package:mamba/models/planning_card.dart';
part 'host_landing_screen_arguments.g.dart';

@JsonSerializable()
class HostLandingScreenArguments {
  final String sessionName;
  final String? password;
  final List<PlanningCard> availableCards;
  final bool automaticallyCompleteVoting;

  HostLandingScreenArguments({
    required this.sessionName,
    this.password,
    this.availableCards = const [],
    this.automaticallyCompleteVoting = false,
  });

  factory HostLandingScreenArguments.fromJson(Map<String, dynamic> data) =>
      _$HostLandingScreenArgumentsFromJson(data);

  Map<String, dynamic> toJson() => _$HostLandingScreenArgumentsToJson(this);
}
