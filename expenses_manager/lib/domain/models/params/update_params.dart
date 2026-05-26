import 'package:expenses_manager/domain/models/transaction_model.dart';

class UpdateParams {
  final String transactionId;
  final TransactionModel transaction;

  UpdateParams({required this.transactionId, required this.transaction});
}