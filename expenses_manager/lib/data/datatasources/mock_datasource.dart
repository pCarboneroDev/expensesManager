import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/utils/transaction_type.dart';
import 'package:flutter/material.dart';

class MockDatasource {
  Either<Failure, List<CategoryModel>> getAllCategories() {
    try {
      final List<CategoryModel> categories = [
        CategoryModel(id: 1, name: 'Alimentación', icon: Icons.restaurant),
        CategoryModel(id: 2, name: 'Transporte', icon: Icons.directions_car),
        CategoryModel(id: 3, name: 'Entretenimiento', icon: Icons.movie),
        CategoryModel(id: 4, name: 'Salud', icon: Icons.favorite),
        CategoryModel(id: 5, name: 'Educación', icon: Icons.school),
        CategoryModel(id: 6, name: 'Salario', icon: Icons.work),
        CategoryModel(id: 7, name: 'Inversiones', icon: Icons.trending_up),
      ];

      return Right(categories);
    } catch (error) {
      return Left(DataSourceException(e.toString()));
    }
  }

  Either<Failure, List<TransactionModel>> getAllMovements() {
    try {
      final categories = _getAllCategories();

      final List<TransactionModel> movements = [
        TransactionModel(
          id: 0,
          date: DateTime(2026, 2, 21),
          amount: 1198.32,
          category: _getRandomCategory(categories),
          type: TransactionType.expense,
        ),
        TransactionModel(
          id: 1,
          date: DateTime(2026, 2, 20),
          amount: 250.00,
          category: _getRandomCategory(categories),
          type: TransactionType.expense,
        ),
        TransactionModel(
          id: 2,
          date: DateTime(2026, 2, 18),
          amount: 3200.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 3,
          date: DateTime(2026, 2, 15),
          amount: 89.99,
          category: _getRandomCategory(categories),
          type: TransactionType.expense,
        ),
        TransactionModel(
          id: 4,
          date: DateTime(2026, 3, 10),
          amount: 540.75,
          category: _getRandomCategory(categories),
          type: TransactionType.expense,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          amount: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          amount: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          amount: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          amount: 1500.00,
          category: _getRandomCategory(categories),
          type: TransactionType.income,
        ),
        TransactionModel(
          id: 5,
          date: DateTime(2026, 3, 5),
          amount: 1500.00,
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

  List<CategoryModel> _getAllCategories() {
    final List<CategoryModel> categories = [
      CategoryModel(id: 1, name: 'Alimentación', icon: Icons.restaurant),
      CategoryModel(id: 2, name: 'Transporte', icon: Icons.directions_car),
      CategoryModel(id: 3, name: 'Entretenimiento', icon: Icons.movie),
      CategoryModel(id: 4, name: 'Salud', icon: Icons.favorite),
      CategoryModel(id: 5, name: 'Educación', icon: Icons.school),
      CategoryModel(id: 6, name: 'Salario', icon: Icons.work),
      CategoryModel(id: 7, name: 'Inversiones', icon: Icons.trending_up),
    ];

    return categories;
  }
}
