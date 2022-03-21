import 'package:uuid/uuid.dart';

class PlanningCommand {
  final Uuid uuid;
  final String type;
  final Object? message;

  PlanningCommand({required this.uuid, required this.type, this.message});
}
