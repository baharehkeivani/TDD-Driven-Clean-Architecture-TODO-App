import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/features/todo/domain/entities/task.dart';
import 'package:todo_app/features/todo/presentation/cubits/add_task_cubit.dart';

import '../../data/mock/mocks.mocks.dart';
import '../../domain/entities/task_test.dart';

void main() {
  /// Note: Mockito is not smart enough to generate a dummy value of type 'Either<Failure, Task>'.
  /// So we must consider using either 'provideDummy' or 'provideDummyBuilder' to give Mockito a proper dummy value.
  provideDummy<Either<Failure, Task>>(Right(task));
  provideDummy<Either<Failure, Task>>(Left(UnknownFailure()));

  late MockTasksService mockService;

  setUp(() {
    mockService = MockTasksService();
  });

  group('AddTaskCubit', () {
    blocTest<AddTaskCubit, GetState>(
      'emits [LoadingGetState, SuccessGetState] when addTask succeeds',
      build: () {
        when(mockService.addTask(any)).thenAnswer((_) async => Right(task));
        return AddTaskCubit(mockService);
      },
      act: (cubit) => cubit.addTask(task),
      expect: () => [LoadingGetState(), SuccessGetState(task)],
    );

    blocTest<AddTaskCubit, GetState>(
      'emits [LoadingGetState, FailureGetState] when addTask fails',
      build: () {
        when(mockService.addTask(any)).thenAnswer((_) async => Left(UnknownFailure()));
        return AddTaskCubit(mockService);
      },
      act: (cubit) => cubit.addTask(task),
      expect: () => [LoadingGetState(), FailureGetState(UnknownFailure())],
    );
  });
}
