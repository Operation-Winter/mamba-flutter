// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_previous_ticket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningPreviousTicketMessage _$PlanningPreviousTicketMessageFromJson(
        Map<String, dynamic> json) =>
    PlanningPreviousTicketMessage(
      previousTickets: (json['previousTickets'] as List<dynamic>)
          .map((e) => PlanningTicket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanningPreviousTicketMessageToJson(
        PlanningPreviousTicketMessage instance) =>
    <String, dynamic>{
      'previousTickets':
          instance.previousTickets.map((e) => e.toJson()).toList(),
    };
