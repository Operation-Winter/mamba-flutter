// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_spectate_session_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningSpectateSessionMessage _$PlanningSpectateSessionMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningSpectateSessionMessage(
      sessionCode: json['sessionCode'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$PlanningSpectateSessionMessageToJson(
        PlanningSpectateSessionMessage instance) =>
    <String, dynamic>{
      'sessionCode': instance.sessionCode,
      'password': instance.password,
    };
