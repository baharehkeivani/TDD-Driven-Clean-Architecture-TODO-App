import 'package:either_dart/either.dart';
import 'package:todo_app/core/errors/domain/entities/failure.dart';
import 'package:todo_app/features/task/domain/entities/task.dart';

abstract interface class TasksRepository {
  Future<Either<Failure, String>> addTask(Task task);

  Future<Either<Failure, void>> removeTask(String id);

  Future<Either<Failure, void>> editTask(String id, Task task);

  Future<Either<Failure, Task>> getTask(String id);
}
