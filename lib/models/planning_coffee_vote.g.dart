// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_coffee_vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningCoffeeVote _$PlanningCoffeeVoteFromJson(Map<String, dynamic> json) =>
    PlanningCoffeeVote(
      participantId:
          PlanningCoffeeVote._idFromString(json['participantId'] as String),
      vote: json['vote'] as bool,
    );

Map<String, dynamic> _$PlanningCoffeeVoteToJson(PlanningCoffeeVote instance) =>
    <String, dynamic>{
      'participantId': PlanningCoffeeVote._stringFromId(instance.participantId),
      'vote': instance.vote,
    };
