import 'package:json_annotation/json_annotation.dart';

part 'join_landing_screen_arguments.g.dart';

@JsonSerializable()
class JoinLandingScreenArguments {
  final String sessionCode;
  final String? password;
  final String username;

  JoinLandingScreenArguments({
    required this.sessionCode,
    this.password,
    required this.username,
  });

  factory JoinLandingScreenArguments.fromJson(Map<String, dynamic> data) =>
      _$JoinLandingScreenArgumentsFromJson(data);

  Map<String, dynamic> toJson() => _$JoinLandingScreenArgumentsToJson(this);
}
