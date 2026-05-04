import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/prediction_repository.dart';
import 'package:expenses_manager/domain/usecases/usecase.dart';

class PredictUsecase implements UseCase<void, double> {
  final PredictionRepository repo;

  PredictUsecase(this.repo);

  @override
  Future<Either<Failure, double>> call(void params) {
    return repo.predict();
  }
}