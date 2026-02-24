import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';

class MockDatasource {
  List<CategoryModel> getAllCategories() {
    final List<CategoryModel> categories = [
      CategoryModel(id: 0, name: 'Food'),
      CategoryModel(id: 1, name: 'Transport'),
      CategoryModel(id: 2, name: 'Entertainment'),
      CategoryModel(id: 3, name: 'Health'),
      CategoryModel(id: 4, name: 'Shopping'),
      CategoryModel(id: 5, name: 'Education'),
      CategoryModel(id: 6, name: 'Bills'),
      CategoryModel(id: 7, name: 'Travel'),
    ];

    return categories;
  }

  Either<Failure, List<TransactionModel>> getAllMovements() {
    try {
      final categories = getAllCategories();
      final List<TransactionModel> movements = [
        TransactionModel(
          id: 0,
          date: DateTime(2026, 2, 21),
          quantity: 1198.32,
          category: _getRandomCategory(categories),
          type: TransactionType.expense,
        ),
        TransactionModel(
          id: 1,
          date: DateTime(2026, 2, 20),
          quantity: 250.00,
          category: _getRandomCategory(categories),
          type: TransactionType.expense,
        ),
        TransactionModel(
          id: 2,
          date: DateTime(2026, 2, 18),
          quantity: 3200.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 3,
          date: DateTime(2026, 2, 15),
          quantity: 89.99,
          category: _getRandomCategory(categories),
          type: TransactionType.expense,
        ),
        TransactionModel(
          id: 4,
          date: DateTime(2026, 3, 10),
          quantity: 540.75,
          category: _getRandomCategory(categories),
          type: TransactionType.expense,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          quantity: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          quantity: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          quantity: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          quantity: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          quantity: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
      ];
      return Right(movements);
    } catch (e) {
      return Left(DataSourceException(e.toString()));
    }
  }

  CategoryModel _getRandomCategory(List<CategoryModel> categories) {
    final rng = Random();
    final index = rng.nextInt(categories.length);
    return categories[index];
  }
}
