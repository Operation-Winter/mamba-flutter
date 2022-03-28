// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningParticipant _$PlanningParticipantFromJson(Map<String, dynamic> json) =>
    PlanningParticipant(
      participantId:
          PlanningParticipant._idFromString(json['participantId'] as String),
      name: json['name'] as String,
      connected: json['connected'] as bool,
    );

Map<String, dynamic> _$PlanningParticipantToJson(
        PlanningParticipant instance) =>
    <String, dynamic>{
      'participantId':
          PlanningParticipant._stringFromId(instance.participantId),
      'name': instance.name,
      'connected': instance.connected,
    };
