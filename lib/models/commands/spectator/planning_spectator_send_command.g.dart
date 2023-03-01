// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_spectator_send_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningSpectatorSendCommand _$PlanningSpectatorSendCommandFromJson(
        Map<String, dynamic> json) =>
    PlanningSpectatorSendCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: json['message'] == null
          ? null
          : PlanningMessage.fromJson(json['message'] as Map<String, dynamic>),
      type:
          $enumDecode(_$PlanningSpectatorSendCommandTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlanningSpectatorSendCommandToJson(
        PlanningSpectatorSendCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand.stringFromId(instance.uuid),
      'type': _$PlanningSpectatorSendCommandTypeEnumMap[instance.type]!,
      'message': instance.message?.toJson(),
    };

const _$PlanningSpectatorSendCommandTypeEnumMap = {
  PlanningSpectatorSendCommandType.JOIN_SESSION: 'JOIN_SESSION',
  PlanningSpectatorSendCommandType.LEAVE_SESSION: 'LEAVE_SESSION',
  PlanningSpectatorSendCommandType.RECONNECT: 'RECONNECT',
};
