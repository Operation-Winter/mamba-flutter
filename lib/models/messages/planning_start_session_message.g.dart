// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_start_session_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningStartSessionMessage _$PlanningStartSessionMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningStartSessionMessage(
      sessionName: json['sessionName'] as String,
      autoCompleteVoting: json['autoCompleteVoting'] as bool,
      availableCards: (json['availableCards'] as List<dynamic>)
          .map((e) => $enumDecode(_$PlanningCardEnumMap, e))
          .toList(),
      password: json['password'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$PlanningStartSessionMessageToJson(
        PlanningStartSessionMessage instance) =>
    <String, dynamic>{
      'sessionName': instance.sessionName,
      'autoCompleteVoting': instance.autoCompleteVoting,
      'availableCards':
          instance.availableCards.map((e) => _$PlanningCardEnumMap[e]).toList(),
      'password': instance.password,
      'tags': instance.tags.toList(),
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
