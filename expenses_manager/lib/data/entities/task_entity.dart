import 'package:expenses_manager/utils/operation_type.dart';
import 'package:expenses_manager/utils/sync_status.dart';

class TaskEntity {
  final String entityType;
  final String entityId;
  final OperationType operation;
  final String? payload;
  final DateTime createdAt;
  final int attempts;
  final SyncStatus status;

  TaskEntity({required this.entityType, required this.entityId, required this.operation, this.payload, required this.createdAt, required this.attempts, required this.status});
}