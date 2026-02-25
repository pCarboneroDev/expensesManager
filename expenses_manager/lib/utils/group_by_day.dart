import 'package:expenses_manager/domain/models/movement_model.dart';

Map<DateTime, List<TransactionModel>> groupTransactionsByDay(
  List<TransactionModel> transactions,
) {
  final Map<DateTime, List<TransactionModel>> grouped = {};

  for (var transaction in transactions) {
    // Normalizamos la fecha para que ignore la hora
    final date = DateTime(
      transaction.date.year,
      transaction.date.month,
      transaction.date.day,
    );

    if (!grouped.containsKey(date)) {
      grouped[date] = [];
    }
    grouped[date]!.add(transaction);
  }

  // Opcional: ordenar las fechas (más recientes primero)
  final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
  final sortedGrouped = Map.fromEntries(
    sortedKeys.map((key) => MapEntry(key, grouped[key]!)),
  );

  return sortedGrouped;
}
