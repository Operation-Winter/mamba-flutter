// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningCommand _$PlanningCommandFromJson(Map<String, dynamic> json) =>
    PlanningCommand(
      uuid: PlanningCommand._idFromString(json['uuid'] as String),
      type: json['type'] as String,
      message: json['message'],
    );

Map<String, dynamic> _$PlanningCommandToJson(PlanningCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand._stringFromId(instance.uuid),
      'type': instance.type,
      'message': instance.message,
    };
