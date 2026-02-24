import 'package:dartz/dartz.dart';
import 'package:expenses_manager/domain/exceptions/failure.dart';

abstract class UseCase<Input, Output> {
  Future<Either<Failure, Output>> call(Input params);
}