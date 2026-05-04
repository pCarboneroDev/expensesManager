import 'package:dartz/dartz.dart';
import 'package:expenses_manager/data/datatasources/remote_datasource.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';
import 'package:expenses_manager/domain/repositories/prediction_repository.dart';

class PredictionRepositoryImpl implements PredictionRepository {
  final RemoteDatasource datasource;

  PredictionRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, double>> predict() {
    return datasource.predict();
  }
}