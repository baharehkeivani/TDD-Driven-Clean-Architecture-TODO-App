import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/errors/domain/entities/failure.dart';
import 'package:todo_app/features/task/data/repositories/tasks_repository.dart';
import 'package:todo_app/features/task/domain/entities/task.dart';
import '../../../../core/configurations/domain/entities/environment.dart';

@LazySingleton(as: TasksRepository)
@Environment(developmentEnv)
class TasksRepositoryMockImp implements TasksRepository {
  @override
  Future<Either<Failure, String>> addTask(Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> editTask(String id, Task task) {
    // TODO: implement editTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Task>> getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeTask(String id) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByDate(DateTime date) {
    // TODO: implement getTasksByDate
    throw UnimplementedError();
  }
}
