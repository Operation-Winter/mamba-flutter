// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_landing_screen_arguments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostLandingScreenArguments _$HostLandingScreenArgumentsFromJson(
        Map<String, dynamic> json) =>
    HostLandingScreenArguments(
      sessionName: json['sessionName'] as String,
      password: json['password'] as String?,
      availableCards: (json['availableCards'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PlanningCardEnumMap, e))
              .toList() ??
          const [],
      automaticallyCompleteVoting:
          json['automaticallyCompleteVoting'] as bool? ?? false,
    );

Map<String, dynamic> _$HostLandingScreenArgumentsToJson(
        HostLandingScreenArguments instance) =>
    <String, dynamic>{
      'sessionName': instance.sessionName,
      'password': instance.password,
      'availableCards': instance.availableCards
          .map((e) => _$PlanningCardEnumMap[e]!)
          .toList(),
      'automaticallyCompleteVoting': instance.automaticallyCompleteVoting,
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
