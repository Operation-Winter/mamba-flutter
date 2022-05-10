// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_ticket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningTicketMessage _$PlanningTicketMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningTicketMessage(
      title: json['title'] as String,
      description: json['description'] as String?,
      selectedTags: (json['selectedTags'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$PlanningTicketMessageToJson(
        PlanningTicketMessage instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'selectedTags': instance.selectedTags.toList(),
    };
