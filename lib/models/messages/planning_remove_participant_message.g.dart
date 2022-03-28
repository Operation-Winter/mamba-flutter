// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_remove_participant_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningRemoveParticipantMessage _$PlanningRemoveParticipantMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningRemoveParticipantMessage(
      participantId: PlanningRemoveParticipantMessage._idFromString(
          json['participantId'] as String),
    );

Map<String, dynamic> _$PlanningRemoveParticipantMessageToJson(
        PlanningRemoveParticipantMessage instance) =>
    <String, dynamic>{
      'participantId': PlanningRemoveParticipantMessage._stringFromId(
          instance.participantId),
    };
