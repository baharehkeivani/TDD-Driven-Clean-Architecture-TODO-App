import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/configurations/domain/usecases/dependencies.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/features/todo/data/repositories/tasks_repository.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';

@LazySingleton()
final class TasksService {
  final TasksRepository _repository;

  TasksService() : _repository = getIt<TasksRepository>();

  Future<Either<Failure, void>> addTask(Task task) =>
      _repository.addTask(task);

  Future<Either<Failure, void>> removeTask(String id) =>
      _repository.removeTask(id);

  Future<Either<Failure, Task>> getTask(String id) => _repository.getTask(id);

  Future<Either<Failure, List<Task>>> getTasksByDate(DateTime date) =>
      _repository.getTasksByDate(date);

  Future<Either<Failure, bool>> toggleTaskState(String id) =>
      _repository.toggleTaskState(id);
}
