// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_landing_screen_arguments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinLandingScreenArguments _$JoinLandingScreenArgumentsFromJson(
        Map<String, dynamic> json) =>
    JoinLandingScreenArguments(
      sessionCode: json['sessionCode'] as String,
      password: json['password'] as String?,
      username: json['username'] as String,
    );

Map<String, dynamic> _$JoinLandingScreenArgumentsToJson(
        JoinLandingScreenArguments instance) =>
    <String, dynamic>{
      'sessionCode': instance.sessionCode,
      'password': instance.password,
      'username': instance.username,
    };
