import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/mock_datasource.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository{
  final MockDatasource dataSource;

  const CategoriesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return await dataSource.getAllCategories();
  }
}