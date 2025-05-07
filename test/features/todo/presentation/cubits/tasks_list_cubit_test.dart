import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/presentation/cubits/tasks_list_cubit.dart';

import '../../data/mock/mocks.mocks.dart';
import '../../domain/entities/task_test.dart';

void main() {
  /// Note: Mockito is not smart enough to generate a dummy value of type 'Either<Failure, Task>'.
  /// So we must consider using either 'provideDummy' or 'provideDummyBuilder' to give Mockito a proper dummy value.
  provideDummy<Either<Failure, List<Task>>>(Right([task]));
  provideDummy<Either<Failure, List<Task>>>(Left(UnknownFailure()));

  late MockTasksService mockService;
  late final TasksListCubit cubit;

  setUp(() {
    mockService = MockTasksService();
    cubit = cubit;
  });

  group('TasksListCubit', () {
    blocTest<TasksListCubit, GetState>(
      'emits [LoadingGetState, SuccessGetState] when fetchTasks succeeds',
      build: () {
        when(mockService.getTasksByDate(any)).thenAnswer((_) async => Right([task]));
        return cubit;
      },
      act: (cubit) => cubit.fetchTasks(DateTime.now()),
      expect:
          () => [
            LoadingGetState(),
            SuccessGetState([task]),
          ],
    );

    blocTest<TasksListCubit, GetState>(
      'emits [LoadingGetState, FailureGetState] when fetchTasks fails',
      build: () {
        when(mockService.getTasksByDate(any)).thenAnswer((_) async => Left(UnknownFailure()));
        return cubit;
      },
      act: (cubit) => cubit.fetchTasks(DateTime.now()),
      expect: () => [LoadingGetState(), FailureGetState(UnknownFailure())],
    );

    blocTest<TasksListCubit, GetState>(
      'emits [SuccessGetState] with task added when addTask is called',
      build: () => cubit,
      act: (cubit) => cubit.addTask(task),
      expect:
          () => [
            SuccessGetState([task]),
          ],
    );

    blocTest<TasksListCubit, GetState>(
      'emits [SuccessGetState] with task removed when removeTask is called',
      build: () {
        cubit.addTask(task);
        return cubit;
      },
      act: (cubit) => cubit.removeTask(task),
      expect: () => [SuccessGetState([])],
    );
  });
}
