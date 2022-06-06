import 'package:json_annotation/json_annotation.dart';

part 'spectator_landing_screen_arguments.g.dart';

@JsonSerializable()
class SpectatorLandingScreenArguments {
  final String sessionCode;
  final String? password;

  SpectatorLandingScreenArguments({
    required this.sessionCode,
    this.password,
  });

  factory SpectatorLandingScreenArguments.fromJson(Map<String, dynamic> data) =>
      _$SpectatorLandingScreenArgumentsFromJson(data);

  Map<String, dynamic> toJson() =>
      _$SpectatorLandingScreenArgumentsToJson(this);
}
