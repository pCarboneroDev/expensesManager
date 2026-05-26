import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/local_datasource.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository{
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;

  const CategoriesRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return await localDatasource.getAllCategories();
  }
}