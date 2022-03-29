// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_join_send_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningJoinSendCommand _$PlanningJoinSendCommandFromJson(
        Map<String, dynamic> json) =>
    PlanningJoinSendCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: json['message'],
      type: $enumDecode(_$PlanningJoinSendCommandTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlanningJoinSendCommandToJson(
        PlanningJoinSendCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand.stringFromId(instance.uuid),
      'message': instance.message,
      'type': _$PlanningJoinSendCommandTypeEnumMap[instance.type],
    };

const _$PlanningJoinSendCommandTypeEnumMap = {
  PlanningJoinSendCommandType.JOIN_SESSION: 'JOIN_SESSION',
  PlanningJoinSendCommandType.VOTE: 'VOTE',
  PlanningJoinSendCommandType.LEAVE_SESSION: 'LEAVE_SESSION',
  PlanningJoinSendCommandType.RECONNECT: 'RECONNECT',
  PlanningJoinSendCommandType.CHANGE_NAME: 'CHANGE_NAME',
};
