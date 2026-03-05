import 'package:expenses_manager/domain/models/movement_model.dart';

class UpdateParams {
  final int transactionId;
  final TransactionModel transaction;

  UpdateParams({required this.transactionId, required this.transaction});
}