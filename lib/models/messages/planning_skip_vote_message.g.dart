// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_skip_vote_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningSkipVoteMessage _$PlanningSkipVoteMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningSkipVoteMessage(
      participantId: PlanningSkipVoteMessage._idFromString(
          json['participantId'] as String),
    );

Map<String, dynamic> _$PlanningSkipVoteMessageToJson(
        PlanningSkipVoteMessage instance) =>
    <String, dynamic>{
      'participantId':
          PlanningSkipVoteMessage._stringFromId(instance.participantId),
    };
