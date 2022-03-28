// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningTicket _$PlanningTicketFromJson(Map<String, dynamic> json) =>
    PlanningTicket(
      title: json['title'] as String,
      description: json['description'] as String?,
      ticketVotes: (json['ticketVotes'] as List<dynamic>?)
              ?.map(
                  (e) => PlanningTicketVote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PlanningTicketToJson(PlanningTicket instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'ticketVotes': instance.ticketVotes.map((e) => e.toJson()).toList(),
    };
