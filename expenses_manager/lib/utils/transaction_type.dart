enum TransactionType {
  expense, 
  income;

  static TransactionType fromString(String type) {
    return TransactionType.values.firstWhere(
      (e) => e.name == type.toLowerCase(),
      orElse: () => TransactionType.expense, // valor por defecto
    );
  }  
}