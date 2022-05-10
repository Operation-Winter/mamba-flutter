// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_vote_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningVoteMessage _$PlanningVoteMessageFromJson(Map<String, dynamic> json) =>
    PlanningVoteMessage(
      selectedCard: $enumDecode(_$PlanningCardEnumMap, json['selectedCard']),
      tag: json['tag'] as String?,
    );

Map<String, dynamic> _$PlanningVoteMessageToJson(
        PlanningVoteMessage instance) =>
    <String, dynamic>{
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
