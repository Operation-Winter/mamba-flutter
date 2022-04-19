// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_session_state_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningSessionStateMessage _$PlanningSessionStateMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningSessionStateMessage(
      sessionCode: json['sessionCode'] as String,
      sessionName: json['sessionName'] as String,
      availableCards: (json['availableCards'] as List<dynamic>)
          .map((e) => $enumDecode(_$PlanningCardEnumMap, e))
          .toList(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => PlanningParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      ticket: json['ticket'] == null
          ? null
          : PlanningTicket.fromJson(json['ticket'] as Map<String, dynamic>),
      timeLeft: json['timeLeft'] as int?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toSet(),
      spectatorCount: json['spectatorCount'] as int,
      coffeeRequestCount: json['coffeeRequestCount'] as int,
      coffeeVotes: (json['coffeeVotes'] as List<dynamic>?)
          ?.map((e) => PlanningCoffeeVote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanningSessionStateMessageToJson(
        PlanningSessionStateMessage instance) =>
    <String, dynamic>{
      'sessionCode': instance.sessionCode,
      'sessionName': instance.sessionName,
      'availableCards':
          instance.availableCards.map((e) => _$PlanningCardEnumMap[e]).toList(),
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'ticket': instance.ticket?.toJson(),
      'timeLeft': instance.timeLeft,
      'tags': instance.tags.toList(),
      'spectatorCount': instance.spectatorCount,
      'coffeeRequestCount': instance.coffeeRequestCount,
      'coffeeVotes': instance.coffeeVotes?.map((e) => e.toJson()).toList(),
    };

const _$PlanningCardEnumMap = {
  PlanningCard.ZERO: 'ZERO',
  PlanningCard.ONE: 'ONE',
  PlanningCard.TWO: 'TWO',
  PlanningCard.THREE: 'THREE',
  PlanningCard.FIVE: 'FIVE',
  PlanningCard.EIGHT: 'EIGHT',
  PlanningCard.THIRTEEN: 'THIRTEEN',
  PlanningCard.TWENTY: 'TWENTY',
  PlanningCard.FOURTY: 'FOURTY',
  PlanningCard.HUNDRED: 'HUNDRED',
  PlanningCard.QUESTION: 'QUESTION',
};
