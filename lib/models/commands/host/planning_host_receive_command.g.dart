// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_host_receive_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningHostReceiveCommand _$PlanningHostReceiveCommandFromJson(
        Map<String, dynamic> json) =>
    PlanningHostReceiveCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: json['message'],
      type: $enumDecode(_$PlanningHostReceiveCommandTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlanningHostReceiveCommandToJson(
        PlanningHostReceiveCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand.stringFromId(instance.uuid),
      'message': instance.message,
      'type': _$PlanningHostReceiveCommandTypeEnumMap[instance.type],
    };

const _$PlanningHostReceiveCommandTypeEnumMap = {
  PlanningHostReceiveCommandType.NONE_STATE: 'NONE_STATE',
  PlanningHostReceiveCommandType.VOTING_STATE: 'VOTING_STATE',
  PlanningHostReceiveCommandType.FINISHED_STATE: 'FINISHED_STATE',
  PlanningHostReceiveCommandType.INVALID_COMMAND: 'INVALID_COMMAND',
  PlanningHostReceiveCommandType.PREVIOUS_TICKETS: 'PREVIOUS_TICKETS',
};
