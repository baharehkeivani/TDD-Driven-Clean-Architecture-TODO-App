import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todo_app/core/extensions/date_time_extension.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/features/todo/domain/repositories/tasks_repository.dart';
import 'package:todo_app/features/todo/data/repositories/tasks_repository_imp.dart';
import '../../domain/entities/task_test.dart';
import '../mock/mocks.mocks.dart';


void main() {
  late MockTasksDatasource mockDatasource;
  late TasksRepository repository;

  setUp(() {
    mockDatasource = MockTasksDatasource();
    repository = TasksRepositoryImp(mockDatasource);
  });

  group("Adding A New Task", () {
    /// Success
    test('should return Right(task) when add is successful', () async {
      when(mockDatasource.add(any)).thenAnswer((_) async => task);

      final result = await repository.addTask(task);

      expect(result.isRight, true);
      expect(result.right, task);
    });

    /// Failure
    test('should return Left(WriteFailure) when add returns null', () async {
      when(mockDatasource.add(any)).thenAnswer((_) async => null);

      final result = await repository.addTask(task);

      expect(result.isLeft, true);
      expect(result.left, isA<WriteFailure>());
    });

    /// Unexpected Exception
    test('should return Left(WriteFailure) when exception is thrown', () async {
      when(mockDatasource.add(any)).thenThrow(Exception('Unexpected'));

      final result = await repository.addTask(task);

      expect(result.isLeft, true);
      expect(result.left, isA<WriteFailure>());
    });
  });

  group("Getting A Task By Its Id", () {
    /// Success
    test('should return Right(task) when getTask is successful', () async {
      when(mockDatasource.getById(any)).thenAnswer((_) async => task);

      final result = await repository.getTask(task.id);

      expect(result.isRight, true);
      expect(result.right, task);
    });

    /// Failure
    test('should return Left(ReadFailure) when getTask returns null', () async {
      when(mockDatasource.getById(any)).thenAnswer((_) async => null);

      final result = await repository.getTask(task.id);

      expect(result.isLeft, true);
      expect(result.left, isA<ReadFailure>());
    });

    /// Unexpected Exception
    test('should return Left(ReadFailure) when exception is thrown', () async {
      when(mockDatasource.getById(any)).thenThrow(Exception('Unexpected'));

      final result = await repository.getTask(task.id);

      expect(result.isLeft, true);
      expect(result.left, isA<ReadFailure>());
    });
  });

  group("Getting A Task By Its DateTime", () {
    /// Success
    final today = DateTime.now();
    test('should return Right(task) when getTasksByDate is successful', () async {
      when(mockDatasource.getAll()).thenAnswer((_) async => tasks);

      final result = await repository.getTasksByDate(today);

      expect(result.isRight, true);
      expect(result.right, tasks.where((element) => element.createdDate.isAtSameDateAs(today)));
    });

    /// Unexpected Exception
    test('should return Left(ReadFailure) when exception is thrown', () async {
      when(mockDatasource.getAll()).thenThrow(Exception('Unexpected'));

      final result = await repository.getTasksByDate(today);

      expect(result.isLeft, true);
      expect(result.left, isA<ReadFailure>());
    });
  });

  group("Toggling Task's State", () {
    final toggledTask = task.toggleStatus();

    /// Success
    test('should return Right(taskState) when toggleTaskState is successful', () async {
      when(mockDatasource.edit(toggledTask, (p0) => p0.id == task.id)).thenAnswer((_) async {});

      final result = await repository.toggleTaskState(task);

      expect(result.isRight, true);
      expect(result.right, toggledTask.isDone);
    });
  });

  group("Removing A Task By Its Id", () {
    /// Success
    test('should return Right(task) when removeTask is successful', () async {
      when(mockDatasource.remove(any)).thenAnswer((_) async {});

      final result = await repository.removeTask(task.id);

      expect(result.isRight, true);
    });

    /// Unexpected Exception
    test('should return Left(DeleteFailure) when exception is thrown', () async {
      when(mockDatasource.remove(any)).thenThrow(Exception('Unexpected'));

      final result = await repository.getTask(task.id);

      expect(result.isLeft, true);
      expect(result.left, isA<ReadFailure>());
    });
  });
}
