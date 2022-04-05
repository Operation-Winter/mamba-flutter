// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningCommand _$PlanningCommandFromJson(Map<String, dynamic> json) =>
    PlanningCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
    );

Map<String, dynamic> _$PlanningCommandToJson(PlanningCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand.stringFromId(instance.uuid),
    };
