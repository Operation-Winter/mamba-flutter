// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_spectator_receive_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningSpectatorReceiveCommand _$PlanningSpectatorReceiveCommandFromJson(
        Map<String, dynamic> json) =>
    PlanningSpectatorReceiveCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: json['message'] == null
          ? null
          : PlanningMessage.fromJson(json['message'] as Map<String, dynamic>),
      type: $enumDecode(
          _$PlanningSpectatorReceiveCommandTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlanningSpectatorReceiveCommandToJson(
        PlanningSpectatorReceiveCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand.stringFromId(instance.uuid),
      'type': _$PlanningSpectatorReceiveCommandTypeEnumMap[instance.type],
      'message': instance.message?.toJson(),
    };

const _$PlanningSpectatorReceiveCommandTypeEnumMap = {
  PlanningSpectatorReceiveCommandType.NONE_STATE: 'NONE_STATE',
  PlanningSpectatorReceiveCommandType.VOTING_STATE: 'VOTING_STATE',
  PlanningSpectatorReceiveCommandType.FINISHED_STATE: 'FINISHED_STATE',
  PlanningSpectatorReceiveCommandType.INVALID_COMMAND: 'INVALID_COMMAND',
  PlanningSpectatorReceiveCommandType.INVALID_SESSION: 'INVALID_SESSION',
  PlanningSpectatorReceiveCommandType.END_SESSION: 'END_SESSION',
  PlanningSpectatorReceiveCommandType.SESSION_IDLE_TIMEOUT:
      'SESSION_IDLE_TIMEOUT',
};
