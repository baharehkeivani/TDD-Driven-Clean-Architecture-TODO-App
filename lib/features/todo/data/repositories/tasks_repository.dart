import 'package:either_dart/either.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';

abstract interface class TasksRepository {
  Future<Either<Failure, void>> addTask(Task task);

  Future<Either<Failure, void>> removeTask(String id);

  Future<Either<Failure, Task>> getTask(String id);

  Future<Either<Failure, List<Task>>> getTasksByDate(DateTime date);

  Future<Either<Failure, bool>> toggleTaskState(String id);
}
