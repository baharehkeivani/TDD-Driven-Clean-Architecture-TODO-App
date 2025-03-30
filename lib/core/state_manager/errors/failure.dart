sealed class Failure {
  String get message;
}

class NetworkFailure extends Failure {
  @override
  String get message =>
      "Failed to connect to the network. Please check your internet connection.";
}

class ServerFailure extends Failure {
  final String? _message;

  ServerFailure({String? message}) : _message = message;

  @override
  String get message =>
      _message ?? "A server error occurred. Please try again later.";
}

abstract class DatabaseFailure extends Failure {}

class ReadFailure extends DatabaseFailure {
  @override
  String get message =>
      "Failed to read data from the database. Please try again.";
}

class WriteFailure extends DatabaseFailure {
  @override
  String get message =>
      "Failed to write data to the database. Please check your storage and try again.";
}

class DeleteFailure extends DatabaseFailure {
  @override
  String get message =>
      "Failed to delete the record from the database. Please try again.";
}

class UnknownFailure extends Failure {
  @override
  String get message => "An unknown error occurred. Please try again later.";
}
