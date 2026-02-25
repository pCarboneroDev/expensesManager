import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
} 