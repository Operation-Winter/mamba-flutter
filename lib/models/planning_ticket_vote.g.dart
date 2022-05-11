// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_ticket_vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningTicketVote _$PlanningTicketVoteFromJson(Map<String, dynamic> json) =>
    PlanningTicketVote(
      participantId:
          PlanningTicketVote._idFromString(json['participantId'] as String),
      selectedCard:
          $enumDecodeNullable(_$PlanningCardEnumMap, json['selectedCard']),
      tag: json['tag'] as String?,
    );

Map<String, dynamic> _$PlanningTicketVoteToJson(PlanningTicketVote instance) =>
    <String, dynamic>{
      'participantId': PlanningTicketVote._stringFromId(instance.participantId),
      'selectedCard': _$PlanningCardEnumMap[instance.selectedCard],
      'tag': instance.tag,
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
