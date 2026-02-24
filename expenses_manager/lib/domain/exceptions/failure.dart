abstract class Failure implements Exception {
  final String message;

  Failure(this.message);
}

class DataSourceException extends Failure{
  DataSourceException(super.message);
}