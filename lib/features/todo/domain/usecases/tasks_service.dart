import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/features/todo/domain/repositories/tasks_repository.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';

@LazySingleton()
class TasksService {
  final TasksRepository _repository;

  TasksService(this._repository);

  Future<Either<Failure, Task>> addTask(Task task) => _repository.addTask(task);

  Future<Either<Failure, void>> removeTask(String id) => _repository.removeTask(id);

  Future<Either<Failure, Task>> getTask(String id) => _repository.getTask(id);

  Future<Either<Failure, List<Task>>> getTasksByDate(DateTime date) => _repository.getTasksByDate(date);

  Future<Either<Failure, bool>> toggleTaskState(Task task) => _repository.toggleTaskState(task);
}
