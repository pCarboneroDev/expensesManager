
import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/domain/repositories/categories_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';

class GetCategoriesUsecase implements UseCase<void, List<CategoryModel>>{
  final CategoriesRepository repo;

  const GetCategoriesUsecase(this.repo);

  @override
  Future<Either<Failure, List<CategoryModel>>> call(void params) {
    return repo.getCategories();
  }
}