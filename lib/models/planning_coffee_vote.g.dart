// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_coffee_vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningCoffeeVote _$PlanningCoffeeVoteFromJson(Map<String, dynamic> json) =>
    PlanningCoffeeVote(
      uuid: PlanningCoffeeVote._idFromString(json['uuid'] as String),
      vote: json['vote'] as bool,
    );

Map<String, dynamic> _$PlanningCoffeeVoteToJson(PlanningCoffeeVote instance) =>
    <String, dynamic>{
      'uuid': PlanningCoffeeVote._stringFromId(instance.uuid),
      'vote': instance.vote,
    };
