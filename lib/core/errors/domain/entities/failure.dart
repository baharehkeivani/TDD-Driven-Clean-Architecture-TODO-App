import 'package:flutter/material.dart';

sealed class Failure {
  String getMessage(BuildContext context);
}

class NetworkFailure extends Failure {
  @override
  String getMessage(BuildContext context) => ""; // TODO
}

class ServerFailure extends Failure {
  final String? message;

  ServerFailure({this.message});

  @override
  String getMessage(BuildContext context) => message ?? ""; // TODO
}

abstract class DatabaseFailure extends Failure {}

class ReadFailure extends DatabaseFailure {
  @override
  String getMessage(BuildContext context) => ""; // TODO
}

class WriteFailure extends DatabaseFailure {
  @override
  String getMessage(BuildContext context) => ""; // TODO
}

class UnknownFailure extends Failure {
  @override
  String getMessage(BuildContext context) => ""; // TODO
}
