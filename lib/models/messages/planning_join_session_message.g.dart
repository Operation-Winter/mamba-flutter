// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_join_session_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningJoinSessionMessage _$PlanningJoinSessionMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningJoinSessionMessage(
      sessionCode: json['sessionCode'] as String,
      participantName: json['participantName'] as String,
    );

Map<String, dynamic> _$PlanningJoinSessionMessageToJson(
        PlanningJoinSessionMessage instance) =>
    <String, dynamic>{
      'sessionCode': instance.sessionCode,
      'participantName': instance.participantName,
    };
