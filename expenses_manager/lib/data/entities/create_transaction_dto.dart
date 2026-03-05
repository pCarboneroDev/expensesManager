class CreateTransactionDto {
  final DateTime date;
  final String userId;
  final double amount;
  final int categoryId;
  final String type;

  CreateTransactionDto({required this.date, required this.userId, required this.amount, required this.categoryId, required this.type});


    Map<String, dynamic> toMap() => {
    "date": date.toString(),
    "user_id": userId,
    "amount": amount,
    "id_category": categoryId,
    "transaction_type": type
  };
}