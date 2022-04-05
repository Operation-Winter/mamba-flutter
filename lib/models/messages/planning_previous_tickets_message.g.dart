// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_previous_tickets_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningPreviousTicketsMessage _$PlanningPreviousTicketsMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningPreviousTicketsMessage(
      previousTickets: (json['previousTickets'] as List<dynamic>)
          .map((e) => PlanningTicket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanningPreviousTicketsMessageToJson(
        PlanningPreviousTicketsMessage instance) =>
    <String, dynamic>{
      'previousTickets':
          instance.previousTickets.map((e) => e.toJson()).toList(),
    };
