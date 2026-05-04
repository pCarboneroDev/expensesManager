import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';

abstract class PredictionRepository {
  Future<Either<Failure, double>> predict();
}