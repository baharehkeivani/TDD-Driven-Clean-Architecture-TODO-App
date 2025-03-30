import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/configurations/domain/usecases/dependencies.dart';
import 'package:todo_app/core/extensions/date_time_extension.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/features/todo/data/datasources/tasks_datesource.dart';
import 'package:todo_app/features/todo/data/repositories/tasks_repository.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import '../../../../core/configurations/domain/entities/environment.dart';

@LazySingleton(as: TasksRepository)
@Environment(developmentEnv)
class TasksRepositoryImp implements TasksRepository {
  final TasksDatasource _localDatasource;

  TasksRepositoryImp() : _localDatasource = getIt<TasksDatasource>();

  @override
  Future<Either<Failure, Task>> addTask(Task task) async {
    try {
      final result = await _localDatasource.add(task);
      if (result == null) return Left(WriteFailure());
      return Right(task);
    } catch (e) {
      return Left(WriteFailure());
    }
  }

  @override
  Future<Either<Failure, Task>> getTask(String id) async {
    try {
      final result = await _localDatasource.getById(id);
      if (result == null) return Left(ReadFailure());
      return Right(result);
    } catch (e) {
      return Left(ReadFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeTask(String id) async {
    try {
      _localDatasource.remove(id);
      return Right(null);
    } catch (e) {
      return Left(DeleteFailure());
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByDate(DateTime date) async {
    try {
      final tasks = await _localDatasource.getAll();
      final tasksByDate =
          tasks
              .where((element) => element.createdDate.isAtSameDateAs(date))
              .toList();
      return Right(tasksByDate);
    } catch (e) {
      return Left(ReadFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> toggleTaskState(Task task) async {
    try {
      final newTask = task.toggleStatus();
      await _localDatasource.edit(newTask, (e) => e.id == newTask.id);
      return Right(newTask.isDone);
    } catch (e) {
      return Left(WriteFailure());
    }
  }
}
