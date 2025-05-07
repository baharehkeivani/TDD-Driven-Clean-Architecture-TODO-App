import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:either_dart/either.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/domain/usecases/tasks_service.dart';

import '../../data/mock/mocks.mocks.dart';
import '../entities/task_test.dart';

void main() {
  /// Note: Mockito is not smart enough to generate a dummy value of type 'Either<Failure, Task>'.
  /// So we must consider using either 'provideDummy' or 'provideDummyBuilder' to give Mockito a proper dummy value.
  setUpAll(() {
    // Register dummy values once
    final dummyFailures = [
      Left<Failure, List<Task>>(UnknownFailure()),
      Left<Failure, Task>(UnknownFailure()),
      Left<Failure, bool>(UnknownFailure()),
      Left<Failure, void>(UnknownFailure()),
    ];
    final dummySuccesses = [
      Right<Failure, List<Task>>([task]),
      Right<Failure, Task>(task),
      Right<Failure, bool>(false),
      Right<Failure, void>(null),
    ];

    for (final dummy in [...dummyFailures, ...dummySuccesses]) {
      provideDummy(dummy);
    }
  });


  late MockTasksRepository mockRepository;
  late TasksService service;

  setUp(() {
    mockRepository = MockTasksRepository();
    service = TasksService(mockRepository);
  });

  group('Add Task', () {
    test('returns Right(task) on success', () async {
      when(mockRepository.addTask(task)).thenAnswer((_) async => Right(task));

      final result = await service.addTask(task);

      expect(result.isRight, true);
      expect(result.right, task);
    });

    test('returns Left(WriteFailure) on failure', () async {
      when(mockRepository.addTask(task)).thenAnswer((_) async => Left(WriteFailure()));

      final result = await service.addTask(task);

      expect(result.isLeft, true);
      expect(result.left, isA<WriteFailure>());
    });
  });

  group('Remove Task', () {
    test('returns Right(void) on success', () async {
      when(mockRepository.removeTask(task.id)).thenAnswer((_) async => const Right(null));

      final result = await service.removeTask(task.id);

      expect(result.isRight, true);
    });

    test('returns Left(DeleteFailure) on failure', () async {
      when(mockRepository.removeTask(task.id)).thenAnswer((_) async => Left(DeleteFailure()));

      final result = await service.removeTask(task.id);

      expect(result.isLeft, true);
      expect(result.left, isA<DeleteFailure>());
    });
  });

  group('Get Task', () {
    test('returns Right(task) on success', () async {
      when(mockRepository.getTask(task.id)).thenAnswer((_) async => Right(task));

      final result = await service.getTask(task.id);

      expect(result.isRight, true);
      expect(result.right, task);
    });

    test('returns Left(ReadFailure) on failure', () async {
      when(mockRepository.getTask(task.id)).thenAnswer((_) async => Left(ReadFailure()));

      final result = await service.getTask(task.id);

      expect(result.isLeft, true);
      expect(result.left, isA<ReadFailure>());
    });
  });

  group('Get Tasks By Date', () {
    final date = DateTime.now();
    final filteredTasks =
        tasks
            .where((t) => t.createdDate.day == date.day && t.createdDate.month == date.month && t.createdDate.year == date.year)
            .toList();

    test('returns Right(List<Task>) on success', () async {
      when(mockRepository.getTasksByDate(date)).thenAnswer((_) async => Right(filteredTasks));

      final result = await service.getTasksByDate(date);

      expect(result.isRight, true);
      expect(result.right, filteredTasks);
    });

    test('returns Left(ReadFailure) on failure', () async {
      when(mockRepository.getTasksByDate(date)).thenAnswer((_) async => Left(ReadFailure()));

      final result = await service.getTasksByDate(date);

      expect(result.isLeft, true);
      expect(result.left, isA<ReadFailure>());
    });
  });

  group('Toggle Task State', () {
    final toggledTask = task.toggleStatus();

    test('returns Right(bool) on success', () async {
      when(mockRepository.toggleTaskState(task)).thenAnswer((_) async => Right(toggledTask.isDone));

      final result = await service.toggleTaskState(task);

      expect(result.isRight, true);
      expect(result.right, toggledTask.isDone);
    });

    test('returns Left(WriteFailure) on failure', () async {
      when(mockRepository.toggleTaskState(task)).thenAnswer((_) async => Left(WriteFailure()));

      final result = await service.toggleTaskState(task);

      expect(result.isLeft, true);
      expect(result.left, isA<WriteFailure>());
    });
  });
}
