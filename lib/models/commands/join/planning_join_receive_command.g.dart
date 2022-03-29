// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_join_receive_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningJoinReceiveCommand _$PlanningJoinReceiveCommandFromJson(
        Map<String, dynamic> json) =>
    PlanningJoinReceiveCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: json['message'],
      type: $enumDecode(_$PlanningJoinReceiveCommandTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlanningJoinReceiveCommandToJson(
        PlanningJoinReceiveCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand.stringFromId(instance.uuid),
      'message': instance.message,
      'type': _$PlanningJoinReceiveCommandTypeEnumMap[instance.type],
    };

const _$PlanningJoinReceiveCommandTypeEnumMap = {
  PlanningJoinReceiveCommandType.NONE_STATE: 'NONE_STATE',
  PlanningJoinReceiveCommandType.VOTING_STATE: 'VOTING_STATE',
  PlanningJoinReceiveCommandType.FINISHED_STATE: 'FINISHED_STATE',
  PlanningJoinReceiveCommandType.INVALID_COMMAND: 'INVALID_COMMAND',
  PlanningJoinReceiveCommandType.INVALID_SESSION: 'INVALID_SESSION',
  PlanningJoinReceiveCommandType.REMOVE_PARTICIPANT: 'REMOVE_PARTICIPANT',
  PlanningJoinReceiveCommandType.END_SESSION: 'END_SESSION',
};
