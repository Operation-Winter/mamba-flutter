// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_host_send_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningHostSendCommand _$PlanningHostSendCommandFromJson(
        Map<String, dynamic> json) =>
    PlanningHostSendCommand(
      uuid: PlanningCommand.idFromString(json['uuid'] as String?),
      message: json['message'] == null
          ? null
          : PlanningMessage.fromJson(json['message'] as Map<String, dynamic>),
      type: $enumDecode(_$PlanningHostSendCommandTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlanningHostSendCommandToJson(
        PlanningHostSendCommand instance) =>
    <String, dynamic>{
      'uuid': PlanningCommand.stringFromId(instance.uuid),
      'type': _$PlanningHostSendCommandTypeEnumMap[instance.type]!,
      'message': instance.message?.toJson(),
    };

const _$PlanningHostSendCommandTypeEnumMap = {
  PlanningHostSendCommandType.START_SESSION: 'START_SESSION',
  PlanningHostSendCommandType.ADD_TICKET: 'ADD_TICKET',
  PlanningHostSendCommandType.SKIP_VOTE: 'SKIP_VOTE',
  PlanningHostSendCommandType.REMOVE_PARTICIPANT: 'REMOVE_PARTICIPANT',
  PlanningHostSendCommandType.END_SESSION: 'END_SESSION',
  PlanningHostSendCommandType.FINISH_VOTING: 'FINISH_VOTING',
  PlanningHostSendCommandType.REVOTE: 'REVOTE',
  PlanningHostSendCommandType.RECONNECT: 'RECONNECT',
  PlanningHostSendCommandType.EDIT_TICKET: 'EDIT_TICKET',
  PlanningHostSendCommandType.ADD_TIMER: 'ADD_TIMER',
  PlanningHostSendCommandType.CANCEL_TIMER: 'CANCEL_TIMER',
  PlanningHostSendCommandType.PREVIOUS_TICKETS: 'PREVIOUS_TICKETS',
  PlanningHostSendCommandType.REQUEST_COFFEE_BREAK: 'REQUEST_COFFEE_BREAK',
  PlanningHostSendCommandType.START_COFFEE_BREAK_VOTE:
      'START_COFFEE_BREAK_VOTE',
  PlanningHostSendCommandType.FINISH_COFFEE_BREAK_VOTE:
      'FINISH_COFFEE_BREAK_VOTE',
  PlanningHostSendCommandType.END_COFFEE_BREAK_VOTE: 'END_COFFEE_BREAK_VOTE',
  PlanningHostSendCommandType.COFFEE_BREAK_VOTE: 'COFFEE_BREAK_VOTE',
};
