import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/mock_datasource.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository{
  final MockDatasource dataSource;
  final RemoteDatasource remoteDatasource;

  const CategoriesRepositoryImpl(this.dataSource, this.remoteDatasource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return await remoteDatasource.getAllCategories();
  }
}