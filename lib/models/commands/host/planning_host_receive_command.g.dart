// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_host_receive_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningHostReceiveCommand _$PlanningHostReceiveCommandFromJson(
        Map<String, dynamic> json) =>
    PlanningHostReceiveCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: json['message'] == null
          ? null
          : PlanningMessage.fromJson(json['message'] as Map<String, dynamic>),
      type: $enumDecode(_$PlanningHostReceiveCommandTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlanningHostReceiveCommandToJson(
        PlanningHostReceiveCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand.stringFromId(instance.uuid),
      'type': _$PlanningHostReceiveCommandTypeEnumMap[instance.type]!,
      'message': instance.message?.toJson(),
    };

const _$PlanningHostReceiveCommandTypeEnumMap = {
  PlanningHostReceiveCommandType.NONE_STATE: 'NONE_STATE',
  PlanningHostReceiveCommandType.VOTING_STATE: 'VOTING_STATE',
  PlanningHostReceiveCommandType.FINISHED_STATE: 'FINISHED_STATE',
  PlanningHostReceiveCommandType.INVALID_COMMAND: 'INVALID_COMMAND',
  PlanningHostReceiveCommandType.PREVIOUS_TICKETS: 'PREVIOUS_TICKETS',
  PlanningHostReceiveCommandType.SESSION_IDLE_TIMEOUT: 'SESSION_IDLE_TIMEOUT',
};
